var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
Bongloy.setPublishableKey(publishableKey);

var checkoutForm = document.querySelector('[data-name="paymentForm"]');
checkoutForm.addEventListener('submit', submitHandler, false);

// Submit handler for checkout form.
function submitHandler(event) {
  event.preventDefault();

  /*
  NOTE: `data-name`

  > Using `data-name` to prevent sending credit card information fields to the backend server via HTTP Post
  (according to the security best practice https://www.omise.co/security-best-practices#never-send-card-data-through-your-servers).

  NOTE: `expiry`

  > Our `cardObject` requires `exp_month` and `exp_year` for expiry information. In HTML, we should have two separated fields with selectors as `data-name="expMonth"` and `data-name="expYear"`. So we can set the provide the expiry to `cardObject` with:

  var cardObject = {
    ...
    exp_month: document.querySelector('[data-name="expMonth"]').value,
    exp_year: document.querySelector('[data-name="expYear"]').value,
    ...
  }

  > On the other hand, in this example, we have implemented `jessepollak/card` for better ui.
  Due to this library only need one field for expiry(mm/yyyy), It has a selector named as `data-name="expiry"`.
  To get the value of `month` and `year` as `carcObject's` demand, we can do:

  var expiry = Payment.fns.cardExpiryVal(document.querySelector('[data-name="expiry"]')) //=> {month: 4, year: 2020}
  var cardObject = {
    ...
    exp_month: expiry.month.value,
    exp_year: dexpiry.year.value,
    ...
  }
  */
  var expiry = Payment.fns.cardExpiryVal(document.querySelector('[data-name="expiry"]').value);

  var cardObject = {
    number:     document.querySelector('[data-name="cardNumber"]').value,
    // exp_month: document.querySelector('[data-name="expMonth"]').value,
    // exp_year:  document.querySelector('[data-name="expYear"]').value,
    exp_month:  expiry.month,
    exp_year:   expiry.year,
    cvc:        document.querySelector('[data-name="cvc"]').value
  };

  Bongloy.createToken('card', cardObject, function(statusCode, response) {
    if (statusCode === 201) {
      // Success: assign Bongloy token back to your checkout form.
      document.querySelector('[data-name="cardToken"]').value = response.id;

      // Then, perform a form submit action.
      checkoutForm.submit();
    }
    else {
      // Error: display an error message. Note that `response.error.message` contains
      // a preformatted error message.
      document.querySelector('[data-name="errorMessages"]').innerHTML = response.error.message;
    }
  });
}

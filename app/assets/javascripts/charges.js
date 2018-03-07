var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
Bongloy.setPublishableKey(publishableKey);

var checkoutForm = document.querySelector('[data-name="paymentForm"]');
checkoutForm.addEventListener('submit', submitHandler, false);

// Submit handler for checkout form.
function submitHandler(event) {
  event.preventDefault();

  /*
  NOTE: Using `data-name` to prevent sending credit card information fields to the backend server via HTTP Post
  (according to the security best practice https://www.omise.co/security-best-practices#never-send-card-data-through-your-servers).
  */
  var cardObject = {
    number:    document.querySelector('[data-name="cardNumber"]').value,
    exp_month: document.querySelector('[data-name="expMonth"]').value,
    exp_year:  document.querySelector('[data-name="expYear"]').value,
    cvc:       document.querySelector('[data-name="cvc"]').value
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

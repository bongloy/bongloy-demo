var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
Bongloy.setPublishableKey(publishableKey);

var checkoutForm = document.querySelector('[data-name="paymentForm"]');
checkoutForm.addEventListener('submit', submitHandler, false);

// Submit handler for checkout form.
function submitHandler(event) {
  event.preventDefault();

  var expiry = document.querySelector('[data-name="cardExpiry"]').value.split("/");
  var cardObject = {
    // The HTML in this example uses `data-name` attribute instead of the HTML name attribute to prevent sending credit card information fields to the backend server via HTTP POST

    number:     document.querySelector('[data-name="cardNumber"]').value,
    exp_month:  expiry[0],
    exp_year:   expiry[1],
    cvc:        document.querySelector('[data-name="cardCVC"]').value
    // exp_month: document.querySelector('[data-name="expMonth"]').value,
    // exp_year:  document.querySelector('[data-name="expYear"]').value,

    // The `cardObject` above requires both `exp_month` and `exp_year`. In our HTML, we could have two separate fields to capture both the expiry month and the expiry year with selectors such as `data-name="expMonth"` and `data-name="expYear"`. In this example however, we are using the `jessepollak/card` library (https://github.com/jessepollak/card) which has only has one field for the card expiry.
  };

  Bongloy.createToken('card', cardObject, function(statusCode, response) {
    // hide error messages
    var errorMessages = document.querySelector('[data-name="errorMessages"]');
    errorMessages.classList.remove('d-block');
    errorMessages.classList.add('d-none');

    if (statusCode === 201) {
      // On success, set token in your checkout form
      document.querySelector('[data-name="cardToken"]').value = response.id;

      // Then, submit the form
      checkoutForm.submit();
    }
    else {
      // If unsuccessful, display an error message.
      // Note that `response.error.message` contains a preformatted error message.
      document.querySelector("input[type=submit]").removeAttribute('disabled');
      errorMessages.classList.remove('d-none');
      errorMessages.classList.add('d-block');
      errorMessages.innerHTML = response.error.message;
    }
  });
}
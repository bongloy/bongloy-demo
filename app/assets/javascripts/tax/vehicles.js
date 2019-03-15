var publishableKey = document.head.querySelector("meta[name=bongloy-publishable-key]").content;
Bongloy.setPublishableKey(publishableKey);
try {
  var cleave = new Cleave('#tax_vehicle_plate_number', {
      delimiters: ['-'],
      blocks: [3, 4],
      uppercase: true
  });
} catch (e) {

}


var checkoutForm = document.querySelector('[data-name="taxPaymentForm"]');
var hiddenForm = document.querySelector('[data-name="hiddenForm"]');
checkoutForm.addEventListener('submit', submitHandler, false);

function submitHandler(event) {
  event.preventDefault();

  var expiry = document.querySelector('[data-name="cardExpiry"]').value.split("/");
  var cardObject = {
    number:     document.querySelector('[data-name="cardNumber"]').value,
    exp_month:  expiry[0],
    exp_year:   expiry[1],
    cvc:        document.querySelector('[data-name="cardCVC"]').value
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
      hiddenForm.submit();
    }
    else {
      // If unsuccessful, display an error message.
      // Note that `response.error.message` contains a preformatted error message.
      var submitButton = document.querySelector("input[type=submit]");
      submitButton.removeAttribute('disabled');
      submitButton.value = "Pay Now"
      errorMessages.classList.remove('d-none');
      errorMessages.classList.add('d-block');
      errorMessages.innerHTML = response.error.message;
    }
  });
}

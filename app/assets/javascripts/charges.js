// JQuery is not required for Bongloy.js

// Here we get our Bongloy Publishable Key from a meta tag attribute in the HTML head
// so we don't need to hard-code it the JavaScript

var checkoutForm = document.querySelector('[data-name="paymentForm"]');
var paymentForm = new PaymentForm(checkoutForm, {
  onSuccess: function(){
    checkoutForm.submit();
  }
})
paymentForm.init()

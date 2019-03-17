$(document).ready(function() {
  var cleave = new Cleave('#tax_vehicle_plate_number', {
      delimiters: ['-'],
      blocks: [3, 4],
      uppercase: true
  });
})

var checkoutForm = document.querySelector('[data-name="taxPaymentForm"]');
var hiddenForm = document.querySelector('[data-name="hiddenForm"]');
var paymentForm = new PaymentForm(checkoutForm, {
  onSuccess: function(){
    hiddenForm.submit();
  }
})

paymentForm.init()

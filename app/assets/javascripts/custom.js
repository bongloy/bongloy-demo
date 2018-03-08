docReady(function() {
  // hide Original Form
  var charge_form = document.getElementById("charge_form");
  var inputs = charge_form.querySelectorAll('input');
  inputs.forEach(function(input){
    if(input.type != 'submit'){
      input.setAttribute('type', 'hidden');
    }
  });
  var cardObj = document.getElementsByName("number")[0];
  var cardTarget = document.querySelector('[data-name="cardNumber"]');

  var expiryObj = document.getElementsByName("expiry")[0];
  var expiryMonthTarget = document.querySelector('[data-name="expMonth"]');
  var expiryYearTarget = document.querySelector('[data-name="expYear"]');

  var cvcTarget = document.querySelector('[data-name="cvc"]');
  var cvcObj = document.getElementsByName("cvc")[0];


  var amountTarget = document.getElementById('new_charge_amount');
  var amountObj = document.getElementsByName("amount")[0];
  amountTarget.value = amountObj.value

  // var submitObj = document.getElementById('submit');
  //   submit.addEventListener('click', function(){
  //   document.getElementsByName('commit')[0].click();
  // });

  // Register input event listener
  cardObj.addEventListener("input",function(){
    cardTarget.value = cardObj.value;
  });
  expiryObj.addEventListener("input",function(){
    expiryMonthTarget.value = expiryObj.value.substring(0, 2);
    expiryYearTarget.value = expiryObj.value.substring(2, 4);
  });

  cvcObj.addEventListener("input",function(){
    cvcTarget.value = cvcObj.value;
  });

});

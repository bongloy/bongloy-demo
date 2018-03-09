docReady(function() {

  var cardNumber = document.querySelector('[data-name="cardNumber"]');
  var cardName = document.querySelector('[data-name="cardName"]');
  var expMonth= document.querySelector('[data-name="expMonth"]');
  var expYear = document.querySelector('[data-name="expYear"]');
  var cvc = document.querySelector('[data-name="cvc"]');
  var dispatchAnchor = document.getElementById('card');
  var focused = document.getElementById('focused');

  cardNumber.addEventListener("focus",function(){
    focused.value = "number";
    dispatchEvent(dispatchAnchor);
  });
  cardNumber.addEventListener("input",function(){
    focused.value = "number";
    dispatchEvent(dispatchAnchor);
  });

  cardName.addEventListener("focus",function(){
    focused.value = "name";
    dispatchEvent(dispatchAnchor);
  });

  cardName.addEventListener("input",function(){
    focused.value = "name";
    dispatchEvent(dispatchAnchor);
  });

  expMonth.addEventListener("focus",function(){
    focused.value = "expiry";
    dispatchEvent(dispatchAnchor);
  });
  expMonth.addEventListener("input",function(){
    focused.value = "expiry";
    dispatchEvent(dispatchAnchor);
  });
  expYear.addEventListener("focus",function(){
    focused.value = "expiry";
    dispatchEvent(dispatchAnchor);
  });
  expYear.addEventListener("input",function(){
    focused.value = "expiry";
    dispatchEvent(dispatchAnchor);
  });

  cvc.addEventListener("focus",function(){
    focused.value = "cvc";
    dispatchEvent(dispatchAnchor);
  });

  cvc.addEventListener("input",function(){
    dispatchEvent(dispatchAnchor);
  });

  function dispatchEvent(anchor){
    anchor.dispatchEvent(new Event('click', { bubbles: true}));
  }

});

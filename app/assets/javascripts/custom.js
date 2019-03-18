$(document).ready(function(){
  // Form validations with cleave.js
  new Cleave('[data-name="cardNumber"]', {
    creditCard: true,
    creditCardStrictMode: true,
    onCreditCardTypeChanged: function (type) {
      var icons = ["mastercard", "visa", "diners", "discover", "jcb", "dankort", "unionpay"];
      var icon = (icons.includes(type.toLowerCase()) ? type.toLowerCase() : "credit-card");
      document.getElementById(this.element.dataset.target).className = "pf pf-" + icon;
    }
  });

  new Cleave('[data-name="cardExpiry"]', {
    date: true,
    datePattern: ['m', 'y']
  });

  new Cleave('[data-name="cardCVC"]', {
    numeral: true,
    numeralThousandsGroupStyle: 'none'
  });
});

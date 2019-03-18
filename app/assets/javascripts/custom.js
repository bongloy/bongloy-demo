$(document).ready(function(){

  $('[data-toggle="tooltip"]').tooltip()

  $('[data-name="cardNumber"]').each(function() {
    new Cleave(this, {
      creditCard: true,
      creditCardStrictMode: true,
      onCreditCardTypeChanged: function (type) {
        var icons = ["mastercard", "visa", "diners", "discover", "jcb", "dankort", "unionpay"];
        var icon = (icons.includes(type.toLowerCase()) ? type.toLowerCase() : "credit-card");
        document.getElementById(this.element.dataset.target).className = "pf pf-" + icon;
      }
    });
  });


  $('[data-name="cardExpiry"]').each(function() {
    new Cleave(this, {
      date: true,
      datePattern: ['m', 'y']
    });
  });

  $('[data-name="cardCVC"]').each(function() {
    new Cleave(this, {
      numeral: true,
      numeralThousandsGroupStyle: 'none'
    });
  });

  $('[data-name="plateNumber"]').each(function() {
    new Cleave(this, {
      delimiters: ['-'],
      blocks: [3, 4],
      uppercase: true
    });
  });
});

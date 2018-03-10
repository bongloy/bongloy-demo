// Generating Credit Card - jessepollak/card
var card = new Card({
    form: 'form', // *required*
    container: '.card-wrapper', // *required*

    formSelectors: {
        numberInput: 'input[data-name="cardNumber"]', // optional — default input[name="number"]
        expiryInput: 'input[data-name="expiry"]', // optional — default input[name="expiry"]
        cvcInput: 'input[data-name="cvc"]', // optional — default input[name="cvc"]
        nameInput: 'input[data-name="cardName"]' // optional - defaults input[name="name"]
    },

    formatting: true, // optional - default true

    // Strings for translation - optional
    messages: {
        monthYear: 'mm/yyyy', // optional - default 'month/year'
    },

    // Default placeholders for rendered fields - optional
    placeholders: {
        number: '•••• •••• •••• ••••',
        name: 'Name on Card',
        expiry: '••/••',
        cvc: '•••'
    }
});
// Validating Form - nosir/cleave.js
var cardNumber = new Cleave('[data-name="cardNumber"]', {
  creditCard: true,
});
new Cleave('[data-name="expiry"]', {
    date: true,
    datePattern: ['m', 'y']
});

new Cleave('[data-name="cardName"]', {
    uppercase: true,
    blocks: [0, 9999]
});


new Cleave('#new_charge_amount', {
    numeral: true,
    numeralThousandsGroupStyle: 'none'
});

// Resolve conflict between nosir/cleave.js and jessepollak/card
// This block will make the validations triggered on blur of any inputs.
Array.prototype.slice.call(
  document.getElementsByTagName('input'), 0
).map(input => {
  input.addEventListener('blur', function(){
    this.dispatchEvent(
      new Event('input', { bubbles: true})
    );
  });
})

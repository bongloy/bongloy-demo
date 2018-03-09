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
    },
    debug: false // optional - default false
});

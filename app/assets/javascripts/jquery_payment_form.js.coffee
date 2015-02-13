ERROR_CLASS = "has-error"

jQuery ->
  return unless $('meta[name="bongloy-publishable-key"]').length
  Stripe.setPublishableKey($('meta[name="bongloy-publishable-key"]').attr('content'))
  return unless paymentForm.form().length
  paymentForm.setupForm()

paymentForm =
  form: ->
    return $('*[data-payment-form]')

  cardInput: (input) ->
    paymentForm.form().find("*[data-payment-card-#{input}]")

  ccNumberInput: ->
    paymentForm.cardInput("number")

  ccExpInput: ->
    paymentForm.cardInput("exp")

  ccCvcInput: ->
    paymentForm.cardInput("cvc")

  toggleFormSubmit: (disable) ->
    paymentForm.form().find('input[type=submit]').attr('disabled', disable)

  formGroup: (input) ->
    input.parent(".form-group")

  toggleInputError: (input, error) ->
    formGroup = paymentForm.formGroup(input)
    formGroup.toggleClass(ERROR_CLASS, error)
    input

  showCardType: ->
   paymentForm.ccNumberInput().keyup ->
      self = $(this)
      cardType = $.payment.cardType(self.val())
      helpBlock = paymentForm.formGroup(self).find(".help-block")
      cardTypeIcons = ["amex", "visa", "mastercard", "discover"]

      cardTypeText = cardType || "<i class='fa fa-question'></i>"

      if (cardType in cardTypeIcons)
        cardTypeIcon = "cc-#{cardType}"
        cardTypeText = ""
      else
        cardTypeIcon = "credit-card"

      helpBlock.html("<i class='fa fa-#{cardTypeIcon}'></i> #{cardTypeText}")

  setupForm: ->
    paymentForm.ccNumberInput().payment('formatCardNumber')
    paymentForm.ccExpInput().payment('formatCardExpiry')
    paymentForm.ccCvcInput().payment('formatCardCVC')
    paymentForm.showCardType()

    paymentForm.form().submit (ev) ->
      paymentForm.toggleFormSubmit(true)
      paymentForm.processCard()
      return false

  processCard: ->
    cardNumber = paymentForm.ccNumberInput().val()
    cardType = $.payment.cardType(cardNumber)
    cardExpiry = paymentForm.ccExpInput().payment('cardExpiryVal')
    cardCvc = paymentForm.ccCvcInput().val()
    paymentForm.toggleInputError(paymentForm.ccNumberInput(), !$.payment.validateCardNumber(cardNumber))
    paymentForm.toggleInputError(paymentForm.ccExpInput(), !$.payment.validateCardExpiry(cardExpiry))
    paymentForm.toggleInputError(paymentForm.ccCvcInput(), !$.payment.validateCardCVC(cardCvc, cardType))

    if paymentForm.form().find(".#{ERROR_CLASS}").length
      paymentForm.toggleFormSubmit(false)
      return false

    card =
      number: cardNumber
      expMonth: cardExpiry.month
      expYear: cardExpiry.year
      cvc: cardCvc
    Stripe.createToken(card, paymentForm.handleBongloyResponse)

  handleBongloyResponse: (status, response) ->
    if response.error
      paymentForm.toggleInputError(paymentForm.ccNumberInput(), true)
      paymentForm.toggleFormSubmit(false)
    else
      form = paymentForm.form()
      token = response.id
      form.append($('<input type="hidden" name="stripeToken" />').val(token))
      form.get(0).submit()

ERROR_CLASS = "has-error"
CARD_TYPE_ICONS = ["amex", "visa", "mastercard", "discover"]
NO_EXPIRY_CARD_TYPES = ["acleda"]
NO_CVC_CARD_TYPES = ["acleda"]

jQuery ->
  publishableKey = $('meta[name="bongloy-publishable-key"]').attr('content')
  Bongloy.setPublishableKey(publishableKey) if publishableKey
  paymentForm.setupForm() if paymentForm.form().length
  bongloyCheckoutHandler = bongloyCheckout.handler()

  $(window).bind 'popstate', (e) ->
    bongloyCheckoutHandler.close()

  $('#checkout_qr_code').click (e) ->
    bongloyCheckoutHandler.open()
    e.preventDefault()

bongloyCheckout =
  handler: ->
    checkoutForm = $('*[data-bongloy-checkout-form]')
    checkoutScript = checkoutForm.find('script[data-key]')

    return unless checkoutScript.length

    handlerOptions = {}
    handlerOptions["key"] = checkoutScript.data("key") if checkoutScript.data("key")
    handlerOptions["image"] = checkoutScript.data("image") if checkoutScript.data("image")
    handlerOptions["locale"] = checkoutScript.data("locale") if checkoutScript.data("locale")
    handlerOptions["name"] = checkoutScript.data("name") if checkoutScript.data("name")
    handlerOptions["description"] = checkoutScript.data("description") if checkoutScript.data("description")
    handlerOptions["amount"] = checkoutScript.data("amount") if checkoutScript.data("amount")
    handlerOptions["token"] = (token) ->
      checkoutForm.append($("<input>").attr("type", "hidden").attr("name", "bongloyToken").val(token.id))
      checkoutForm.submit()

    handler = BongloyCheckout.configure(handlerOptions)
    return handler

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

  toggleInputDisabled: (input, disable) ->
    input.attr('disabled', disable)

  formGroup: (input) ->
    input.parent(".form-group")

  toggleInputError: (input, error) ->
    formGroup = paymentForm.formGroup(input)
    formGroup.toggleClass(ERROR_CLASS, error)
    input

  processCardType: ->
   paymentForm.ccNumberInput().keyup ->
      self = $(this)
      cardType = $.payment.cardType(self.val())
      helpBlock = paymentForm.formGroup(self).find(".help-block")
      cardTypeText = cardType || "<i class='fa fa-question'></i>"

      if (cardType in CARD_TYPE_ICONS)
        cardTypeIcon = "cc-#{cardType}"
        cardTypeText = ""
      else
        cardTypeIcon = "credit-card"

      helpBlock.html("<i class='fa fa-#{cardTypeIcon}'></i> #{cardTypeText}")

      if (cardType in NO_EXPIRY_CARD_TYPES)
        paymentForm.toggleInputDisabled(paymentForm.ccExpInput(), true)
      else
        paymentForm.toggleInputDisabled(paymentForm.ccExpInput(), false)

      if (cardType in NO_CVC_CARD_TYPES)
        paymentForm.toggleInputDisabled(paymentForm.ccCvcInput(), true)
      else
        paymentForm.toggleInputDisabled(paymentForm.ccCvcInput(), false)

  setupForm: ->
    paymentForm.ccNumberInput().payment('formatCardNumber')
    paymentForm.ccExpInput().payment('formatCardExpiry')
    paymentForm.ccCvcInput().payment('formatCardCVC')
    paymentForm.processCardType()

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
    if !(cardType in NO_EXPIRY_CARD_TYPES)
      paymentForm.toggleInputError(paymentForm.ccExpInput(), !$.payment.validateCardExpiry(cardExpiry))
    if !(cardType in NO_EXPIRY_CARD_TYPES)
      paymentForm.toggleInputError(paymentForm.ccCvcInput(), !$.payment.validateCardCVC(cardCvc, cardType))

    if paymentForm.form().find(".#{ERROR_CLASS}").length
      paymentForm.toggleFormSubmit(false)
      return false

    card =
      number: cardNumber
      expMonth: cardExpiry.month
      expYear: cardExpiry.year
      cvc: cardCvc
    Bongloy.createToken(card, paymentForm.handleBongloyResponse)

  handleBongloyResponse: (status, response) ->
    if response.error
      paymentForm.toggleInputError(paymentForm.ccNumberInput(), true)
      paymentForm.toggleFormSubmit(false)
    else
      form = paymentForm.form()
      token = response.id
      form.append($('<input type="hidden" name="bongloyToken" />').val(token))
      form.get(0).submit()

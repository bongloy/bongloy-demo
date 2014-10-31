ERROR_CLASS = "has-error"
SUCCESS_CLASS = "has-success"

jQuery ->
  Stripe.setPublishableKey($('meta[name="bongloy-publishable-key"]').attr('content'))
  charge.setupForm()

charge =
  form: ->
    return $('#new_charge_bongloy_js')

  cardInput: (input) ->
    charge.form().find("##{input}")

  ccNumberInput: ->
    charge.cardInput("cc_number")

  ccExpInput: ->
    charge.cardInput("cc_exp")

  ccCvcInput: ->
    charge.cardInput("cc_cvc")

  toggleFormSubmit: (disable) ->
    charge.form().find('input[type=submit]').attr('disabled', disable)

  formGroup: (input) ->
    input.parent(".form-group")

  toggleInputError: (input, error) ->
    formGroup = charge.formGroup(input)
    formGroup.toggleClass(ERROR_CLASS, error)
    formGroup.toggleClass(SUCCESS_CLASS, !error)
    input

  showCardType: ->
   charge.ccNumberInput().keyup ->
      self = $(this)
      cardType = $.payment.cardType(self.val())
      helpBlock = charge.formGroup(self).find(".help-block")
      cardTypeIcons = ["amex", "visa", "mastercard", "discover"]

      cardTypeText = cardType || "<i class='fa fa-question'></i>"

      if (cardType in cardTypeIcons)
        cardTypeIcon = "cc-#{cardType}"
        cardTypeText = ""
      else
        cardTypeIcon = "credit-card"

      helpBlock.html("<i class='fa fa-#{cardTypeIcon}'></i> #{cardTypeText}")

  setupForm: ->
    charge.ccNumberInput().payment('formatCardNumber')
    charge.ccExpInput().payment('formatCardExpiry')
    charge.ccCvcInput().payment('formatCardCVC')
    charge.showCardType()

    charge.form().submit (ev) ->
      ev.preventDefault()
      charge.toggleFormSubmit(true)
      charge.processCard()

  processCard: ->
    cardNumber = charge.ccNumberInput().val()
    cardType = $.payment.cardType(cardNumber)
    cardExpiry = charge.ccExpInput().payment('cardExpiryVal')
    cardCvc = charge.ccCvcInput().val()
    charge.toggleInputError(charge.ccNumberInput(), !$.payment.validateCardNumber(cardNumber))
    charge.toggleInputError(charge.ccExpInput(), !$.payment.validateCardExpiry(cardExpiry))
    charge.toggleInputError(charge.ccCvcInput(), !$.payment.validateCardCVC(cardCvc, cardType))

    if charge.form().find(".#{ERROR_CLASS}").length
      charge.toggleFormSubmit(false)
      return false

    card =
      number: cardNumber
      expMonth: cardExpiry.month
      expYear: cardExpiry.year
      cvc: cardCvc
    Stripe.createToken(card, charge.handleBongloyResponse)

  handleBongloyResponse: (status, response) ->
    if response.error
      charge.toggleInputError(charge.ccNumberInput(), true)
      charge.toggleFormSubmit(false)
    else
      form = charge.form()
      token = response.id
      form.append($('<input type="hidden" name="stripeToken" />').val(token))
      form.get(0).submit()

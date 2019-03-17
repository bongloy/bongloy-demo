class PaymentForm
  constructor: (form, options={})->
    @form = form
    @options = options
    @target = @options.target || '[data-name="cardToken"]'

  init: ->
    @form.addEventListener('submit', @_handleSubmit.bind(@), false);

  _handleSubmit: (e)->
    e.preventDefault()
    self = @
    expiry = document.querySelector('[data-name="cardExpiry"]').value.split("/")
    cardObject = {
      number:     document.querySelector('[data-name="cardNumber"]').value,
      exp_month:  expiry[0],
      exp_year:   expiry[1],
      cvc:        document.querySelector('[data-name="cardCVC"]').value
    }

    Bongloy.createToken 'card', cardObject, (statusCode, response)->
      errorMessages = document.querySelector('[data-name="errorMessages"]');
      errorMessages.classList.remove('d-block');
      errorMessages.classList.add('d-none');
      if statusCode == 201
        self._onSuccess(response)
      else
        self._onFailer(response)

  _onSuccess: (response)->
    document.querySelector(@target).value = response.id;
    @options.onSuccess() if @options.onSuccess

  _onFailer: (response)->
    errorMessages = document.querySelector('[data-name="errorMessages"]');
    document.querySelector("input[type=submit]").removeAttribute('disabled');
    errorMessages.classList.remove('d-none');
    errorMessages.classList.add('d-block');
    errorMessages.innerHTML = response.error.message;
    @options.onFailer() if @options.onFailer


window.PaymentForm = PaymentForm

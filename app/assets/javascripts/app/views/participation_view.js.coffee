class App.Views.ParticipationView extends Backbone.View
  events:
    "keyup .payment input": "paymentTouch"
    "change .payment input": "paymentTouch"
    "keyup .owed_amount input": "owedAmountTouch"
    "change .owed_amount input": "owedAmountTouch"
    "change .owed_type select": "owedTypeTouch"

  initialize: ->
    @model.set
      payment: @$('.payment input').floatVal()
      owed_amount: @$('.owed_amount input').floatVal()
      owed_type: @$('.owed_type select').val()

    @model.on 'change:owed_result', @updateOwedResult, this
    @model.on 'change:owed_type', @updateOwedType, this

  paymentTouch: (event) ->
    @model.set 'payment', parseFloat(event.target.value)

  owedAmountTouch: (event) ->
    @model.set 'owed_amount', parseFloat(event.target.value)

  owedTypeTouch: (event) ->
    @model.set 'owed_type', event.target.value

  updateOwedType: (_, value) ->
    cssClass = if value == "fixed" then "owed-fixed" else "owed-calculated"
    @$el.replaceClasses(cssClass, ['owed-calculated', 'owed-fixed'])

  updateOwedResult: (_, value) ->
    text = currencize value
    @$('.owed-result').text(text)

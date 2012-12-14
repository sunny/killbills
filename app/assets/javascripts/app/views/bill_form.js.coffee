class App.Views.BillForm extends Backbone.View
  el: '#bill-form'

  events:
    "click .radio-toggles input": "tab"

  initialize: ->
    @model.on 'change:genre', @updateGenre, this
    @model.set 'genre', @$('.genre input:checked').val()
    @updateGenre()
    new App.Views.ParticipationList(collection: @model.participations, el: @$('.participations'))

  tab: (event) ->
    @model.set "genre", event.target.value

  updateGenre: ->
    @$el.replaceClasses(@model.get('genre'), @model.GENRES)

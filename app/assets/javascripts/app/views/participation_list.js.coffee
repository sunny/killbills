class App.Views.ParticipationList extends Backbone.View
  initialize: ->
    for row in @$('.row')
      model = new App.Models.Participation()
      @collection.add model
      new App.Views.ParticipationView(el: row, model: model)

class KillBills.Views.ParticipationList extends Backbone.View
  initialize: ->
    for row in @$('.row')
      model = new KillBills.Models.Participation()
      @collection.add model
      new KillBills.Views.ParticipationView(el: row, model: model)

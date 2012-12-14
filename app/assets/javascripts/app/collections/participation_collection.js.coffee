class App.Collections.ParticipationCollection extends Backbone.Collection
  model: App.Models.Participation

  initialize: (collection, options) ->
    @bill = options.bill
    @on "change", =>
      @bill.trigger('change:participations')

  totalPayment: ->
    @reduce((memo, participation) ->
      payment = participation.get('payment')
      memo + if payment then payment else 0
    , 0)

  shared: ->
    @select (participation) ->
      participation.get('owed_type') == "even"

  unshared: ->
    @select (participation) ->
      participation.get('owed_type') != "even"

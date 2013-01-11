class KillBills.Models.Bill extends Backbone.Model
  GENRES: ['debt', 'payment', 'shared']

  defaults:
    genre: "debt"
    title: ""

  initialize: ->
    @participations = new KillBills.Collections.Participations([], bill: @)
    @friends = new KillBills.Collections.Friends
    @on 'change:participations', @updateOwedResults, this

  updateOwedResults: ->
    @evenShare = @evenShareCalculation()
    for participation in @participations.models
      participation.set('owed_result', @owedForParticipation(participation))

  evenShareCalculation: ->
    shared = @participations.shared()
    unshared = @participations.unshared()
    return 0 if shared.length == 0

    @total = @participations.totalPayment()

    total = @total
    total -= @owedForParticipation(p) for p in unshared
    total / shared.length

  # Calculates for a given participation number how much it owes
  owedForParticipation: (participation) =>
    switch participation.get('owed_type')
      when "even"       then @evenShare
      when "zero"       then 0
      when "all"        then @total
      when "fixed"      then participation.get('owed_amount')
      #when "percentage" then @total * participation.get('owed_percent') / 100

  teardown: ->
    @off 'change:participations', @updateOwedResults, this

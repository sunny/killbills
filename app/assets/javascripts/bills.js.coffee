jQuery ->
  new Bill if $('#bill-form').length


class Bill

  constructor: (@form) ->
    @form = $('#bill-form')
    #@participations_people_fields = @form.find('select.people')
    @participations_payment_fields = @form.find('input.payment')
    @participations_owed_fields = @form.find('select.owed')
    @participations_owed_results = @form.find('span.result')

    @collect()
    @update()


  even_share: =>
    log "even_share"
    shared = []
    unshared = []

    for owed, i in @owed
      if owed == "even"
        shared.push i
      else
        unshared.push i
    return 0 if shared.length == 0

    unshared_owed

    # If there are any fixed amounts, deduce them
    if unshared.length
      unshared_owed = 0
      for i in unshared
        unshared_owed += participation_owed(i)

    (@total - unshared_owed) / shared.length

  participation_owed: (i) =>
    log "owed:", i, @owed[i]
    switch @owed[i]
      when "even"       then @even_share()
      when "zero"       then 0
      when "all"        then @total
      #when "percentage" then @total * owed_percent / 100
      #when "fixed"      then owed_amount


  collect: =>
    # Payments array
    @payments = []
    for field in @participations_payment_fields
      @payments.push $(field).floatVal()

    # Owed array
    @owed = []
    for field in @participations_owed_fields
      @owed.push $(field).val()

    # Total
    @total = 0
    @total += payment for payment in @payments
    
    # Owed amounts (needs payments, owed, even_share and total)
    @owed_amounts = []
    for owed, i in @owed
      @owed_amounts.push @participation_owed(i)


  # Refresh the UI
  update: =>
    log "update"

    # Owed array
    for amount, i  in @owed_amounts
      @participations_owed_results.eq(i).text(numberToCurrency amount)


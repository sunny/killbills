class window.Bill

  constructor: (@form) ->
    return if !@form.length

    # Elements on bill
    @genre_fields = @form.find('.genre input')

    # Elements on participations
    @payment_fields =     @form.find('.payment input')
    @owed_type_fields =   @form.find('.owed_type select')
    @owed_amount_fields = @form.find('.owed_amount input')
    @owed_results =       @form.find('.owed-result')

    # Apply events
    @genre_fields.click @update_bill
    @form.click @update_participations
    @form.keyup @update_participations

    # Kickoff events
    @update_bill()
    @update_participations()

  # Return the selected genre via the radio buttons
  genre: =>
    @genre_fields.filter(':checked').val()

  # Calculates what an even share is worth
  even_share_calc: =>
    shared =   (i for owed, i in @owed_types when owed == "even")
    unshared = (i for owed, i in @owed_types when owed != "even")
    return 0 if shared.length == 0
    total = @total
    total -= @owed_calc(i) for i in unshared
    total / shared.length

  # Calculates for a given participation number how much it owes
  owed_calc: (i) =>
    switch @owed_types[i]
      when "even"       then @even_share
      when "zero"       then 0
      when "all"        then @total
      when "fixed"      then @owed_amount_fields.eq(i).floatVal()
      #when "percentage" then @total * owed_percent / 100

  # Get the data from the form and fill @total and @owed_types
  collect: =>
    # Total
    @total = 0
    @total += $(field).floatVal() for field in @payment_fields

    # Owed texts
    @owed_types = ($(field).val() for field in @owed_type_fields)

  # Calculate from the data collected
  calculate: =>
    @collect()

    # Even share
    @even_share = @even_share_calc()

    # Owed amounts
    @owed_amounts = (@owed_calc(i) for owed, i in @owed_types)


  # Refresh the UI

  update_bill: =>
    @form.replaceClasses(@genre(), ['debt', 'payment', 'shared'])
    log 'update_bill'

  update_participations: =>
    @calculate()
    log 'update_participations'

    for field, i in @owed_type_fields
      klass = if $(field).val() == 'fixed' then 'owed-fixed' else 'owed-calculated'
      elem = @owed_results.eq(i).parent()
      elem.replaceClasses(klass, ['owed-calculated', 'owed-fixed'])

    # Fill owed results
    for amount, i  in @owed_amounts
      text = currencize amount
      @owed_results.eq(i).text(text)



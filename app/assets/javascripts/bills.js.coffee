class window.Bill

  constructor: (@form) ->
    return if !@form.length

    @kind_fields = @form.find('.kind input')
    @payment_fields = @form.find('.payment input')
    @owed_amount_fields = @form.find('.owed_amount input')
    @owed_fields = @form.find('.owed')
    @owed_results = @form.find('.owed-result')

    # Events
    @update()
    @form.click @update
    @form.keyup @update

  # Return the selected kind via the radio buttons
  kind: =>
    @kind_fields.filter(':checked').val()

  even_share_calc: =>
    shared =   (i for owed, i in @owed when owed == "even")
    unshared = (i for owed, i in @owed when owed != "even")
    return 0 if shared.length == 0
    total = @total
    total -= @owed_calc(i) for i in unshared
    total / shared.length

  owed_calc: (i) =>
    switch @owed[i]
      when "even"       then @even_share
      when "zero"       then 0
      when "all"        then @total
      #when "percentage" then @total * owed_percent / 100
      #when "fixed"      then owed_amount

  # Update
  update: =>
    @collect()
    @calculate()
    @refresh()

  # Get the data from the form
  collect: =>
    # Total
    @total = 0
    @total += $(field).floatVal() for field in @payment_fields

    # Owed texts
    @owed = []
    @owed.push $(field).val() for field in @owed_fields.find(':checked')

  # Calculate from the data collected
  calculate: =>
    # Even share
    @even_share = @even_share_calc()

    # Owed amounts
    @owed_amounts = []
    @owed_amounts.push @owed_calc(i) for owed, i in @owed

  # Refresh the UI
  refresh: =>
    # Kind
    kind = @kind()
    if kind == 'Debt'
      $('.payment').hide()
      $('.owed').hide()
      $('.owed_amount').show()
    else if kind == 'Payment'
      $('.payment').show()
      $('.owed').hide()
      $('.owed_amount').hide()
    else
      $('.payment').show()
      $('.owed').show()
      $('.owed_amount').show()

    # Owed array
    for amount, i  in @owed_amounts
      @owed_results.eq(i).text(currencize amount)



class window.Bill

  constructor: (@form) ->
    return if !@form.length

    @genre_fields = @form.find('.genre input')
    @payment_fields = @form.find('.payment input')
    @owed_amount_fields = @form.find('.owed_amount input')
    @owed_fields = @form.find('.owed')
    @owed_results = @form.find('.owed-result')

    # Events
    @refresh_genre()
    @update()
    @genre_fields.click @refresh_genre
    @form.click @update
    @form.keyup @update

  # Return the selected genre via the radio buttons
  genre: =>
    @genre_fields.filter(':checked').val()

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

  refresh_genre: =>
    switch @genre()
      when 'debt'
        $('.payment').hide()
        $('.owed').hide()
        $('.owed_amount').show()
      when 'payment'
        $('.payment').show()
        $('.owed').hide()
        $('.owed_amount').hide()
      when 'shared'
        $('.payment').show()
        $('.owed').show()
        $('.owed_amount').show()

  # Refresh the UI
  refresh: =>
    # Kind
    for amount, i  in @owed_amounts
      @owed_results.eq(i).text(currencize amount)



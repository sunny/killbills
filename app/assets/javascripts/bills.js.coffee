jQuery ->
  new Bill if $('#bill-form').length


class Bill

  constructor: (@form) ->
    @form = $('#bill-form')
    @payment_fields = @form.find('input.payment')
    @owed_fields = @form.find('select.owed')
    @owed_results = @form.find('span.result')

    @collect()
    @refresh()


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


  collect: =>
    # Total
    @total = 0
    @total += $(field).floatVal() for field in @payment_fields

    # Owed texts
    @owed = []
    @owed.push $(field).val() for field in @owed_fields

    # Even share
    @even_share = @even_share_calc()
    
    # Owed amounts (needs owed, even_share and total)
    @owed_amounts = []
    @owed_amounts.push @owed_calc(i) for owed, i in @owed


  # Refresh the UI
  refresh: =>
    # Owed array
    for amount, i  in @owed_amounts
      @owed_results.eq(i).text(currencize amount)



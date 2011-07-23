class Bill
  # encoded "€" because of a CoffeeScript encoding error
  currency: decodeURIComponent('%E2%82%AC')

  constructor: ->
    @amount_f       = $('#bill_amount')
    @friend_f       = $('#bill_friend_id')
    @user_ratio_f   = $('#bill_user_ratio')
    @user_payed_f   = $('#bill_user_payed')
    @friend_payed_f = $('#bill_friend_payed')
    @user_payed_label   = $('label[for="bill_user_payed"]')
    @friend_payed_label = $('label[for="bill_friend_payed"]')

    # Create radio buttons instead of amount fields
    @user_payed_c   = $('<input type=radio name=who_payed value=user id=who_payed_user>')
    @friend_payed_c = $('<input type=radio name=who_payed value=friend id=who_payed_friend>')
    if @user_payed() > 0
      @user_payed_c.check()
    else
      @friend_payed_c.check()
    $('#bill_who_payed').find('input, .currency').hide()
    @user_payed_c.insertBefore   @user_payed_label.attr('for', 'who_payed_user')
    @friend_payed_c.insertBefore @friend_payed_label.attr('for', 'who_payed_friend')

    # Create shared checkbox instead of ratio field
    @shared_checkbox = $('<input id=shared type=checkbox name=shared value=1>')
    @shared_label = $('<label for=shared>Shared</label>')
    @shared_checkbox.check() if 1 > @user_ratio() > 0
    $('#bill_shared .field, #bill_shared h2').hide()
    @shared_checkbox.insertBefore $('#bill_shared .field')
    @shared_label.insertAfter @shared_checkbox

    # Create a summary field
    @summary_f = $('<p id="summary"></p>')
    @summary_f.insertAfter @shared_label

    # Update the automatic data
    $('.new_bill, .edit_bill').change(@update)
    @update()

  amount: () ->
    @amount_f.floatval()

  friend_name: () ->
    opts = @friend_f[0].options
    opts[opts.selectedIndex].text || "Your friend"

  user_payed: (v) ->
    if v != undefined then return @user_payed_f.val(v)
    @user_payed_f.floatval()

  friend_payed: (v) ->
    if v != undefined then return @friend_payed_f.val(v)
    @friend_payed_f.floatval()

  user_ratio: (v) ->
    if v != undefined then return @user_ratio_f.val(v)
    @user_ratio_f.floatval()

  friend_ratio: ->
    1 - @user_ratio()

  user_debt: ->
    @user_ratio() * @amount() - @user_payed()

  friend_debt: ->
    @friend_ratio() * @amount() - @friend_payed()

  is_shared: ->
    @shared_checkbox.attr('checked') == 'checked'

  is_user_paying: ->
    @user_payed_c.attr('checked') == 'checked'

  summary: (v) ->
    @summary_f.text v



  # Refresh the UI

  update: =>
    @update_who_payed()
    @update_shared()
    @update_summary()

  # Update the underlying fields
  update_who_payed: ->
    @friend_payed_label.text(@friend_name())
    # Radio buttons decide who payed
    if @is_user_paying()
      @user_payed   @amount()
      @friend_payed 0
    else
      @user_payed   0
      @friend_payed @amount()

  # Set the ratio depending on the share
  update_shared: ->
    @user_ratio(
      if @is_shared()           then 0.5
      else if @is_user_paying() then 0
      else                      1
    )

  # Update text summary

  update_summary: ->
    if (!@amount())
      @summary ''
    else if @user_debt() > 0
      @summary "You owe #{@user_debt()} #{@currency}"
    else if @friend_debt() > 0
      @summary "#{@friend_name()} owes you #{@friend_debt()} #{@currency}"
    else
      @summary ''


window.Bill = Bill


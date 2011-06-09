$ ->

  # On bill creation/update page
  amount = $('#bill_amount')
  if amount.length
    user_payed = $('#bill_user_payed')
    friend_payed = $('#bill_friend_payed')
    user_ratio = $('#bill_user_ratio')
    summary = $('<div id="summary"></div>')

    # Update default values
    update_who_payed = ->
      total = amount.floatval()
      user = user_payed.floatval()
      friend = friend_payed.floatval()

      user_payed.def '0'
      friend_payed.def '0'
      if !user_payed.val()
        user_payed.def(total - friend)
      else if !friend_payed.val()
        friend_payed.def(total - user)

    # Update text summary
    update_text_result = ->
      total = amount.floatval()
      user = user_payed.floatval()
      friend = friend_payed.floatval()
      ratio = user_ratio.intval()
      user_debt = ratio * total - user
      friend_debt = (1 - ratio) * total - friend

      if (!total)
        summary.text ''
      else if user_debt > 0
        summary.text 'You owe '+user_debt+' euro'
      else if friend_debt > 0
        summary.text 'Your friend owes you '+friend_debt+' euro'
      else
        summary.text ''


    summary.insertAfter $('#bill_who_payed')
    update_who_payed()
    update_text_result()
    $('input').change(update_who_payed)
              .change(update_text_result)

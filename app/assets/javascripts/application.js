jQuery(function($) {

  // Extract the floating value of an input
  $.fn.floatval = function() {
    return $(this).val() ? parseFloat($(this).val()) : 0
  }
  $.fn.intval = function() {
    return $(this).val() ? parseInt($(this).val(), 10) : 0
  }

  // Store the default value for a field
  $.fn.def = function(v) {
    return $(this).attr('placeholder', v)
  }

  // On bill creation/update page
  var amount = $('#bill_amount')
  if (amount.length) {
     var user_payed = $('#bill_user_payed'),
        friend_payed = $('#bill_friend_payed'),
        user_ratio = $('#bill_user_ratio'),
        summary = $('<div id="summary"></div>')

    // Update default values
    function update_who_payed() {
      var total = amount.floatval(),
          user = user_payed.floatval(),
          friend = friend_payed.floatval()

      user_payed.def('0')
      friend_payed.def('0')
      if (!user_payed.val())
        user_payed.def(total - friend)
      else if (!friend_payed.val())
        friend_payed.def(total - user)
    }

    // Update text summary
    function update_text_result() {
      var total = amount.floatval(),
          user = user_payed.floatval(),
          friend = friend_payed.floatval(),
          ratio = user_ratio.intval(),
          user_debt = ratio * total - user,
          friend_debt = (1-ratio) * total - friend

      if (!total)
        summary.text('')
      else if (user_debt > 0)
        summary.text('You owe ' + user_debt + ' €')
      else if (friend_debt > 0)
        summary.text('Your friend owes you ' + friend_debt + ' €')
      else
        summary.text('')

    }

    summary.insertAfter($('#bill_who_payed'))

    update_who_payed()
    update_text_result()
    $('input').change(update_who_payed)
              .change(update_text_result)
  }
})

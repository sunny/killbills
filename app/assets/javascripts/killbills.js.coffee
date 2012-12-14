window.KillBills =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}


$(document).ready ->
  $('html').removeClass('noJs').addClass('js')

  # Bill form
  if $('#bill-form').length >= 1
    window.bill = new KillBills.Models.Bill()
    new KillBills.Views.BillForm(model: bill)
    #$('select[data-new-value]').selectNewValue()

  # Friends list
  $('#pies').friendsPies('.friend')

  # Make sure hitting "Previous page" does not show the disabled text
  $('input[data-disable-with]').attr('autocomplete', 'off')

  # Add jsloaded class
  $('html').removeClass('nojs').addClass('jsloaded')
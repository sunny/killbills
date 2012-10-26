#= require comment
#= require intercom
#
#= require jquery
#= require jquery_ujs
#
#= require bootstrap-alert
#= require bootstrap-button
#
#= require raphael
#= require g.raphael
#= require g.pie
#= require pies
#
#= require helpers
#= require bills

jQuery ->
  $('html').removeClass('noJs').addClass('js')

  # Bill form
  new Bill($('#bill-form'))
  $('select[data-new-value]').selectNewValue()

  # Friends list
  $('#pies').friendsPies('.friend')

  # Make sure hitting "Previous page" does not show the disabled text
  $('input[data-disable-with]').attr('autocomplete', 'off')

  # Add jsloaded class
  $('html').removeClass('nojs').addClass('jsloaded')

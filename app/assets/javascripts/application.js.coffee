#= require comment
#
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require bootstrap-alert
#= require bootstrap-button
#
#- require intercom
#= require raphael
#= require g.raphael
#= require g.pie
#
#= require helpers
#= require pies
#= require app/main

jQuery ->
  $('html').removeClass('noJs').addClass('js')

  # Bill form
  if $('#bill-form')
    new App.Views.BillForm(model: new App.Models.Bill())
    $('select[data-new-value]').selectNewValue()

  # Friends list
  $('#pies').friendsPies('.friend')

  # Make sure hitting "Previous page" does not show the disabled text
  $('input[data-disable-with]').attr('autocomplete', 'off')

  # Add jsloaded class
  $('html').removeClass('nojs').addClass('jsloaded')

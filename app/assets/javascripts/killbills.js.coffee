
$(document).ready ->
  $('html').removeClass('nojs').addClass('js')

  # Bill form
  if $('#bill-form').length >= 1
    window.bill = new KillBills.Models.Bill()
    new KillBills.Views.BillForm(model: bill)

  # Friends list
  $('#pies').friendsPies('.friend')

  # Make sure hitting "Previous page" does not show the disabled text
  $('input[data-disable-with]').attr('autocomplete', 'off')

  # Persona
  $('body').on 'click', '[data-persona-login]', ->
    navigator.id.get (assertion) ->
      if assertion
        $.ajax
          url: '/users/sign_in'
          type: "POST"
          dataType: "json"
          cache: false
          data:
            assertion: assertion
          success: (data, status) ->
            window.location.href = '/'+I18n.locale
    off

  $('body').on 'click', '[data-persona-logout]', ->
    navigator.id.logout()
    on

  # Add jsloaded class
  $('html').addClass('jsloaded')

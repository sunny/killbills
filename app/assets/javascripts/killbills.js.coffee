# Let CSS know that there is JS
$(document).one 'ready', ->
  $('html').removeClass('nojs').addClass('js')


# Bill form
$(document).ready ->
  if $('#bill-form').length >= 1
    KillBills.topView = new KillBills.Views.BillForm()
$(document).on "page:change", ->
  # Teardown
  if KillBills.topView
    KillBills.topView.remove()
    KillBills.topView = null


# Friends
$(document).ready ->
  $('#pies').friendsPies('.friend')


# Add a fetching class while turbolink operates
$(document).on 'page:fetch', ->
  $('html').addClass('fetching')
$(document).on 'page:change', ->
  $('html').removeClass('fetching')


# Make sure hitting "Previous page" does not show the disabled text
$(document).ready ->
  $('input[data-disable-with]').attr('autocomplete', 'off')


# Persona
$(document).on 'click', '[data-persona-login]', ->
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
$(document).on 'click', '[data-persona-logout]', ->
  navigator.id.logout()
  on

$(document).ready ->
  # Turbo-enabled bootstrap dropdown (data-toggler instead of data-toggle)
  $('[data-toggler]').each -> $(@).dropdown({ toggle: $(@).data('toggler') })

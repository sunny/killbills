/* */

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

  intercom = ->
    i.q = []
    i.c = (args) -> i.q.push(args)
    window.Intercom = i
    async_load = ->
      s = document.createElement('script')
      s.src = 'https://api.intercom.io/api/js/library.js'
      x = document.getElementsByTagName('script')[0]
      x.parentNode.insertBefore(s, x)
    if window.attachEvent
      window.attachEvent 'onload', async_load
    else
      window.addEventListener 'load', async_load, false
  intercom()

  # Bill form
  new Bill($('#bill-form'))
  $('select[data-new-value]').selectNewValue()

  # Friends list
  $('#pies').friendsPies('.friend')

  # Make sure hitting "Previous page" does not show the disabled text
  $('input[data-disable-with]').attr('autocomplete', 'off')

  # Add jsloaded class
  $('html').removeClass('nojs').addClass('jsloaded')

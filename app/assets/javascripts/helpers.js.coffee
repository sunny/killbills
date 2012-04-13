# Console logger
window.log = ->
  console?.log?(arguments...)

# Number with it's currency
window.currencize = (number) ->
  # encoded "€" because of a CoffeeScript encoding error
  # currency = decodeURIComponent('%E2%82%AC')
  '$' + round(number)

# Rounding a number with a given number of decimals
window.round = (number, decimals = 2) ->
  pow = Math.pow(10, decimals)
  Math.round(number * pow) / pow

# Floating value of a field
$.fn.floatVal = ->
  val = @val()
  if val and val.match(/^\d+(\.\d+)?$/)
    parseFloat val
  else
    0

# Int value of a field
$.fn.intVal = ->
  val = @val()
  if val and val.match(/^\d+$/)
    parseInt val, 10
  else
    0

# Change CSS opacity
# Example: $('input').opacity(0.5)
#$.fn.opacity = (val) ->
#  @css('opacity', val)

# Check radios and checkboxes
# Example: $('input').check()
#$.fn.check = ->
#  @attr('checked', 'checked')

# Uncheck html radio and checkboxes
# Example: $('input').uncheck()
#$.fn.uncheck = ->
#  @removeAttr('checked')

# Apply a CSS class and remove it from other elements at the same time
# Example: newElems.takeClass('current', oldElems)
#$.fn.takeClass = (klass, from) ->
#  from.removeClass(klass)
#  @addClass(klass)


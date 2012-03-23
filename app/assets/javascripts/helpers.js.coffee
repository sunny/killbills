# Console logger
window.log = ->
  console?.log?(arguments...)

window.numberToCurrency = (number) ->
  # encoded "€" because of a CoffeeScript encoding error
  # currency = decodeURIComponent('%E2%82%AC')
  currency = '$'
  currency + number

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

# Shorter call to change opacity
$.fn.opacity = (val) ->
  @css('opacity', val)

# Syntaxic sugar to check html radio and checkboxes
$.fn.check = ->
  @attr('checked', 'checked')

# Syntaxic sugar to uncheck html radio and checkboxes
$.fn.uncheck = ->
  @removeAttr('checked')

# Apply a CSS class and remove it from other elements at the same time
# E.g.: newElems.borrowClass('current', oldElems)
$.fn.borrowClass = (klass, from) ->
  from.removeClass(klass)
  @addClass(klass)


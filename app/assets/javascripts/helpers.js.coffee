# Floating value of an input
$.fn.floatval = ->
  val = @val()
  if val && val.match(/^[0-9.]+$/)
    parseFloat val
  else
    0

# Int value of an input
$.fn.intval = ->
  val = @val()
  if val && val.match(/^0-9]+$/)
    parseInt val, 10
  else
    0

# Syntaxic sugar to check html radio and checkboxes
$.fn.check = ->
  @attr('checked', 'checked')

# Syntaxic sugar to uncheck html radio and checkboxes
$.fn.uncheck = ->
  @attr('checked', '')


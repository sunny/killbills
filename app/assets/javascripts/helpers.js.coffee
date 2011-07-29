# Floating value of an input
$.fn.floatVal = ->
  val = @val()
  if val and val.match(/^\d+(\.\d+)?$/)
    parseFloat val
  else
    0

# Int value of an input
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
  @attr('checked', '')

# E.g.: newElems.borrowClass('current', oldElems)
$.fn.borrowClass = (klass, from) ->
  from.removeClass(klass)
  this.addClass(klass)


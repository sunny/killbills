
# Floating value of an input
$.fn.floatval = ->
  if @val() then parseFloat(@val()) else 0

# Int value of an input
$.fn.intval = ->
  if @val() then parseInt(@val(), 10) else 0

# Store the default value for a field
$.fn.def = (v) ->
  @attr('placeholder', v)

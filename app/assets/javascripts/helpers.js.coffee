
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


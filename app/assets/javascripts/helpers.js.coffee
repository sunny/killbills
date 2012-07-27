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

# Adds an option to a select that prompts for a new value.
# Set the name of the option and the text on the prompted alert box
# via "data-new-value" and "data-new-value-prompt" attributes on the select.
#
# Example:
#   <select data-new-value="New product..." data-new-value-prompt="Please enter product name:">
#     ...
#   </select>
#
#   $('select').selectNewValue()
$.fn.selectNewValue =->
  $(this).each ->
    select_text = $(this).data('new-value') || 'Add new...'
    prompt_text = $(this).data('new-value-prompt') || 'New value'

    option = $('<option value="new">').text(select_text)
    $(this).append option
    $(this).change ->
      # If last element is selected
      return if @selectedIndex != @options.length - 1

      # And a name is given
      person_name = prompt(prompt_text)
      return @selectedIndex = 0 if !person_name

      # Remove previous custom name if any
      $(this).find('option:not([value])').remove()

      # Create a new option
      option = $('<option />').text(person_name)

      # Insert and select it
      option.insertBefore $(this).find('option:last')
      @selectedIndex = @options.length - 2

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

# Adds a class and removes the given classes
$.fn.replaceClasses = (newClass = '', classes) ->
    @removeClass(klass) for klass in classes when klass != 'newClass'
    @addClass(newClass)

# class App.Views.ParticipationList extends Backbone.View
# $.fn.selectNewValue =->
#   $(this).each ->
#     select_text = $(this).data('new-value') || 'Add new...'
#     prompt_text = $(this).data('new-value-prompt') || 'New value'

#     option = $('<option value="new">').text(select_text)
#     $(this).append option
#     $(this).change ->
#       # If last element is selected
#       return if @selectedIndex != @options.length - 1

#       # And a name is given
#       person_name = prompt(prompt_text)
#       return @selectedIndex = 0 if !person_name

#       # Remove previous custom name if any
#       $(this).find('option:not([value])').remove()

#       # Create a new option
#       option = $('<option />').text(person_name)

#       # Insert and select it
#       option.insertBefore $(this).find('option:last')
#       @selectedIndex = @options.length - 2

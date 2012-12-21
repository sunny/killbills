class KillBills.Views.PeopleSelect extends Backbone.View
  events:
    'change select': 'selectTouch'

  initialize: (options) ->
    @parent = options.parent
    @is_me = !@$('select')[0]

    # Initialisation
    for option in @$('option')
      friend = { id: $(option).val(), name: $(option).text() }
      bill.friends.add friend if friend.id

    @render()

    bill.friends.on('change', @render, this)

  selectTouch: (event) ->
    # Clicked on "New…"
    if event.target.selectedIndex == event.target.length - 1
      name = prompt(locales.current.participants.new_prompt)
      if !name
        event.target.selectedIndex = 0
        return

      friend = bill.friends.add({ name: name })
      @parent.model.set('friend', friend)
      @render()
      @$('select').focus()

  render: ->
    data =
      is_me: @is_me
      friends:
        {
          selected: friend.get('id') == @parent.model.friend
          value: friend.get('id') || friend.get('name')
          name: friend.get('name')
        } for friend in bill.friends.models

    html = JST['templates/participations/participants'](data)
    @$el.html html

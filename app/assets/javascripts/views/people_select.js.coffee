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
    # If last ("New…")
    if event.target.selectedIndex == event.target.length - 1
      name = prompt("New friend:")
      if !name
        event.target.selectedIndex = 0
        return

      friend = bill.friends.add({ name: name })
      @parent.model.set('friend', friend)
      @render()

  render: ->
    html = "<div class='column-label'>Participant</div>"
    if @is_me
      html += '<div class="you">You<input id="bill_participations_attributes_0_person_id" name="bill[participations_attributes][0][person_id]" type="hidden" value="6"></div>'
    else
      html += '<select id="bill_participations_attributes_1_person_id" name="bill[participations_attributes][1][person_id]">'
      html += '<option value=""></option>'
      for friend in bill.friends.models
        selected = friend.get('id') == @parent.model.friend
        html += "<option#{if selected then " selected='selected'"}>#{friend.get('name')}</option>"
      html += '<option>New…</option>'
      html += '</select>'
    @$el.html html

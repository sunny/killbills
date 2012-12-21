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
      name = prompt(locales.current.participants.new_prompt)
      if !name
        event.target.selectedIndex = 0
        return

      friend = bill.friends.add({ name: name })
      @parent.model.set('friend', friend)
      @render()
      @$('select').focus()

  render: ->
    html = """
      <div class="column-label">
        #{locales.current.participants.participant}
      </div>
    """

    if @is_me
      html += """
        <div class="you">
          You
          <input id="bill_participations_attributes_0_person_id"
                 name="bill[participations_attributes][0][person_id]"
                 type="hidden" value="#{user_id}">
        </div>
      """
    else
      html += """
        <select id="bill_participations_attributes_1_person_id"
                name="bill[participations_attributes][1][person_id]">
          <option></option>
      """

      for friend in bill.friends.models
        selected = friend.get('id') == @parent.model.friend
        value = friend.get('id') || friend.get('name')
        html += """
          <option #{if selected then 'selected="selected"'} value="#{value}">
            #{friend.get('name')}
          </option>
        """

      html += """
        <option>#{locales.current.participants.new}</option>
      </select>
      """

    @$el.html html

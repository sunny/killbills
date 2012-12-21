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
    @compiledTemplate ||= _.template """
      <div class="column-label">
        <%- locales.current.participants.participant %>
      </div>
      <% if (is_me) { %>
        <div class="you">
          You
          <input id="bill_participations_attributes_0_person_id"
                 name="bill[participations_attributes][0][person_id]"
                 type="hidden" value="<%= user_id %>">
        </div>
      <% } else { %>
        <select id="bill_participations_attributes_1_person_id"
                name="bill[participations_attributes][1][person_id]">
          <option></option>
          <% _.each(friends, function(friend) { %>
            <option <% if (friend.selected) { %>selected="selected"<% } %>
              value="<%- friend.value %>">
              <%- friend.name %>
            </option>
          <% }) %>
          <option><%- locales.current.participants.new %></option>
        </select>
        <% } %>
      """

    data =
      is_me: @is_me
      friends: []

    for friend in bill.friends.models
      data.friends.push
        selected: friend.get('id') == @parent.model.friend
        value: friend.get('id') || friend.get('name')
        name: friend.get('name')

    @$el.html @compiledTemplate(data)

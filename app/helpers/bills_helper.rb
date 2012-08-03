module BillsHelper
  def link_to_friend(person)
    return "You" if person == current_user
    link_to person.name, person
  end

  def debt_summary(debt, options = {})
    amount = currencize(debt.amount)
    from = debt.from_person
    to = debt.to_person

    if options[:links] == true
      method = method(:sprintf_friends_links)
    else
      method = method(:sprintf_friends)
    end

    if from == current_user
      method.call "You owe %s #{amount}", to
    elsif to == current_user
      method.call "%s owes you #{amount}", from
    else
      method.call "%s owes %s #{amount}", from, to
    end
  end

  def sprintf_friends(text, *friends)
    sprintf(text, *friends.map { |friend| friend.display_name })
  end

  def sprintf_friends_links(text, *friends)
    friends = friends.map { |friend| link_to(friend.display_name, friend) }
    sprintf(h(text), *friends).html_safe
  end

end


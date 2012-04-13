module BillsHelper
  def link_to_friend(person)
    return "You" if person == current_user
    link_to person.name, person
  end

  def debt_summary(debt)
    amount = currencize(debt.amount)
    from = debt.from
    to = debt.to
    if from == current_user
      "You owe #{to.title} #{amount}"
    elsif to == current_user
      "#{from.title} owes you #{amount}"
    else
      "#{from.title} owes #{to.title} #{amount}"
    end
  end
end


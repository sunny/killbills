module BillsHelper
  def link_to_friend(person)
    person == current_user_or_guest ? t(:you) : link_to(person.name, person)
  end

  def debt_summary(debt, options = {})
    amount = currencize(debt.amount)
    from = debt.from_person
    to = debt.to_person

    if from == current_user_or_guest
      key = "you_owe"
    elsif to == current_user_or_guest
      key = "owes_you"
    else
      key = "owes"
    end

    if options[:links]
      to = link_to(to.display_name, to) unless to.kind_of?(User)
      from = link_to(from.display_name, from) unless from.kind_of?(User)
    else
      to = to.display_name
      from = from.display_name
    end

    t("debt.summary.#{key}",
      from: from,
      to: to,
      amount: amount).html_safe
  end

end


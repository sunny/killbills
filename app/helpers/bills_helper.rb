module BillsHelper
  def link_to_friend(person)
    person == current_user ? t(:you) : link_to(person.name, person)
  end

  # Title based on the participations
  #
  # Examples:
  # - "Payment from O-Ren"
  # - "Payment with Budd"
  # - "Payment to Beatrix"
  # - "Debt from Pai-Mei"
  # - "Debt with B.B."
  # - "Debt to Bill"
  # - "Shared to Vernita and Nikki"
  def bill_title(bill)
    return bill.title unless bill.title.blank?
    t("debt.name.#{bill.direction}",
      genre: bill.genre.text,
      friends: bill.friend_names.to_sentence)
  end

  def debt_summary(debt, options = {})
    amount = currencize(debt.amount)
    from = debt.from_person
    to = debt.to_person

    if from == current_user
      key = "you_owe"
    elsif to == current_user
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

    t("debt.summary.#{key}", from: from, to: to, amount: amount).html_safe
  end

end


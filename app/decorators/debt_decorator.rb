class DebtDecorator < Draper::Decorator
  delegate_all

  def variation_to(user_id)
    user_id = user_id.id if user_id.respond_to?(:id)
    diff = source.diff_for(user_id)
    h.variation -diff
  end

  def summary(options = {})
    amount = h.user_number_to_currency(source.amount)
    from = source.from_person
    to = source.to_person

    if from == h.current_user_or_guest
      key = "you_owe"
    elsif to == h.current_user_or_guest
      key = "owes_you"
    else
      key = "owes"
    end

    if options[:links]
      to = h.link_to(to.display_name, to) unless to.kind_of?(User)
      from = h.link_to(from.display_name, from) unless from.kind_of?(User)
    else
      to = to.display_name
      from = from.display_name
    end

    I18n.t("debt.summary.#{key}",
      from: from,
      to: to,
      amount: amount).html_safe
  end
end

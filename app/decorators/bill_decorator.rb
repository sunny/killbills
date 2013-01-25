class BillDecorator < Draper::Decorator
  delegate_all
  decorates_association :debts

  # Title based on the participations.
  #
  # Examples:
  # - "Payment from O-Ren"
  # - "Payment with Budd"
  # - "Payment to Beatrix"
  # - "Debt from Pai-Mei"
  # - "Debt with B.B."
  # - "Debt to Bill"
  # - "Shared to Vernita and Nikki"
  def title
    return source.title unless source.title.blank?
    I18n.t("debt.name.#{direction}",
      genre: source.genre.text,
      friends: friend_names.to_sentence)
  end

  # Array of names of participating friends.
  #
  # Equivalent to `participations.friends.map(&:name)`
  # but does not trigger an n+1 when already using
  # `includes(:participations)`.
  def friend_names
    friends = source.participations.reject { |p| p.person_id == source.user_id }.map(&:person)
    friends.map(&:name).sort
  end

  def long_time_ago
    time_ago(:time_ago_long)
  end

  def time_ago(translation_key = :time_ago)
    h.content_tag(:time, datetime: source.date.strftime('%Y-%m-%dT%H:%MZ'), title: source.date) do
      I18n.t(translation_key, time: h.time_ago_in_words(source.date), date: source.date)
    end
  end

  private

    # String representing the direction of the bill
    # relative to the bill user.
    #
    # - "from" : if friend is in debt
    # - "to" : if user is in debt
    # - "with" : if more than one friend
    # - "other"
    def direction
      debt = source.debt
      if debt.nil?
        "other"
      elsif genre.debt?
        debt.to == user_id ? "from" : "to"
      elsif genre.payment?
        debt.to == user_id ? "to" : "from"
      else
        "with"
      end
    end
end

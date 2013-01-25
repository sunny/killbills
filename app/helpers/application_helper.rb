module ApplicationHelper
  # Show an amount in the current user's currency
  def currencize(number, options = {})
    options = options.merge({ unit: current_user_or_guest.currency_unit })
    number_to_currency_without_double_zeros(number, options)
  end

  # number_to_currency that removes trailing .00 but keeps .20
  def number_to_currency_without_double_zeros(number, options = {})
    formatted_number = number_to_currency(number, options)

    defaults           = I18n.translate(:'number.format', :locale => options[:locale], :default => {})
    precision_defaults = I18n.translate(:'number.precision.format', :locale => options[:locale], :default => {})
    defaults           = defaults.merge(precision_defaults)
    options = options.reverse_merge(defaults)
    escaped_separator = Regexp.escape(options[:separator])
    formatted_number.to_s.sub(/#{escaped_separator}00/, '')
  end

  def variation(amount)
    if amount > 0
      :positive
    elsif amount < 0
      :negative
    else
      :zero
    end
  end

  def link_to_friend(person)
    if current_user_or_guest == person
      t(:you)
    else
      link_to(person.name, person)
    end
  end

  # Increment and return an integer, starting at 1.
  #
  # Argument:
  #   - scope: Name of the increment scope.
  #            Defaults to :default.
  #
  # Examples:
  #   incrementer!() #=> 1
  #   incrementer!() #=> 2
  #   incrementer!(:foo) #=> 1
  #   incrementer!(:foo) #=> 2
  #
  #   incrementer() #=> 2
  #   incrementer() #=> 2
  #   incrementer(:foo) #=> 2
  #   incrementer(:foo) #=> 2
  def incrementer!(scope = :default)
    @incrementer ||= Hash.new(0)
    @incrementer[scope] += 1
  end
  def incrementer(scope = :default)
    @incrementer ||= Hash.new(0)
    @incrementer[scope] ||= 0
  end
end

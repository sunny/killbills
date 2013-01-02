# encoding: utf-8
module ApplicationHelper
  include KillBillsHelper

  def ratio(amount)
    number_to_percentage(amount*100, :precision => 0)
  end

  def user_number_to_currency(number)
    number_to_currency(number, unit: current_user_or_guest.currency.text)
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

  def datetime(date)
    date.strftime('%Y-%m-%dT%H:%MZ')
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


# encoding: utf-8
module ApplicationHelper
  include FricoutHelper

  def ratio(amount)
    number_to_percentage(amount*100, :precision => 0)
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
end


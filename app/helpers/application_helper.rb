# encoding: utf-8
module ApplicationHelper
  def money(amount, currency = "€")
    amount = amount.to_f.round(2)
    amount = amount.to_s
    amount.gsub! /\.0$/, ''
    amount.gsub! /\..$/, '\00'
    amount += " #{currency}" unless currency.nil?
    amount
  end

  def ratio(amount)
    percent = (amount * 100).to_s
    percent.gsub! /\.0$/, ''
    "#{percent} %"
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


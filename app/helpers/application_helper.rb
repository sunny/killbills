# encoding: utf-8
module ApplicationHelper
  def money(amount, currency = "€")
    amount = amount.to_s
    amount.gsub! /\.0$/, ''
    amount.gsub! /\..$/, '\00'
    amount += " #{currency}" unless currency.nil?
    amount
  end
end

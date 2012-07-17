# encoding: utf-8
class ActionView::Helpers::FormBuilder
  def number_field(attribute, options={})
    defaults = { size: 5, type: "number" }
    text_field(attribute, defaults.merge(options))
  end

  def money_field(attribute, options={})
    defaults = { min: 0, step: 0.01, data: { currency: "€" } }
    options = defaults.merge(options)

    currency = ""
    if options[:data][:currency]
      currency = content_tag(:span, options[:data][:currency], class: "currency")
    end

    number_field(attribute, options) + currency
  end
end


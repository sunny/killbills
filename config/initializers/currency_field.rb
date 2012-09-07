# encoding: utf-8
class ActionView::Helpers::FormBuilder
  # Returns an input tag of type "number" with default attributes for a
  # currency field.
  #
  # ==== Options
  # * <tt>:unit</tt> - Sets the denomination of the currency. Set to false
  #    to disable showing the unit.
  # * Otherwise accepts the same options as number_field_tag.
  #
  # ==== Examples
  #
  #  f.currency_field(:amount)
  #  => $<input type="number" min="0" step="0.001" size="5" placeholder="0" />
  #
  #  f.currency_field(:amount, :unit => false, :placeholder => "Amount")
  #  => <input type="number" min="0" step="0.001" size="5" placeholder="Amount" />
  def currency_field(method, options = {})
    defaults = {
      min: 0,
      step: 0.01,
      size: 5,
      placeholder: 0,
      unit: true
    }
    options.symbolize_keys!
    options = defaults.merge!(options)
    unit = options.delete(:unit)

    if unit
      unit = I18n.translate(:'number.currency.format.unit') if unit === true
      options[:data] ||= {}
      options[:data][:unit] = unit
    end

    number_field(method, options)
  end
end


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
    options.symbolize_keys!

    defaults = {
      min: 0,
      step: 0.01,
      size: 5,
      placeholder: 0,
      unit: true
    }
    options = defaults.merge!(options)

    field = number_field(method, options)

    unit = options.delete(:unit)
    unit = I18n.translate(:'number.currency.format.unit') if unit === true

    if unit
      format = I18n.translate(:'number.currency.format.format')
      format.gsub(/%n/, unit_tag).gsub(/%u/, unit).html_safe
    else
      field
    end
  end
end


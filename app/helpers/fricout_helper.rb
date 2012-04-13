module FricoutHelper
  include ActionView::Helpers::NumberHelper

  def currencize(number)
    return unless number and number != 0
    formatted_number = number_to_currency(number)
    formatted_number.sub(/\.00$/, '')
  end
end

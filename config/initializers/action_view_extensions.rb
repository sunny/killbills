# encoding: utf-8
module ActionView
  module Helpers
    class FormBuilder
      def number_field(attribute, options={})
        defaults = {
          :size => 5,
          :type => "number"
        }
        text_field(attribute, defaults.merge(options))
      end

      def money_field(attribute, options={})
        defaults = {
          :min => 0,
          :step => 0.01,
          :'data-currency' => "€"
        }
        options = defaults.merge(options)

        currency = options[:'data-currency'] ? " <span class=\"currency\">#{options[:'data-currency']}</span>" : ''

        number_field(attribute, options) + currency.html_safe
      end
    end
  end
end


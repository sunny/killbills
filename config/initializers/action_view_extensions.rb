# encoding: utf-8
module ActionView
  module Helpers
    class FormBuilder
      def number_field(attribute, options={})
        defaults = {
          :size => 5,
          :type => "number",
          :maxlength => (options[:size].nil? ? 5 : options[:size])
        }
        text_field(attribute, defaults.merge(options))
      end

      def money_field(attribute, options={})
        defaults = { :min => 0, :step => 0.01 }
        number_field(attribute, defaults.merge(options)) + ' <span class="currency">€</span> '.html_safe
      end
    end
  end
end


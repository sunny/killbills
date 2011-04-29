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
        number_field(attribute, options) + ' € '
      end
    end
  end
end


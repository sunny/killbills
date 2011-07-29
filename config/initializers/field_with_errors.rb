module Fricout
  class Application
    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
      include ActionView::Helpers::RawOutputHelper
      raw %(<span class="field_with_errors">#{html_tag}</span>)
    end
  end
end


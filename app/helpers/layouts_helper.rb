module LayoutsHelper
  def title(title)
    content_for(:page_title){ title }
  end

  def page_title
    if content_for?(:page_title)
      title = content_for(:page_title)
    else
      title = t("#{controller.controller_name}.#{controller.action_name}.title")
    end

    "#{title} - #{t(:app_name)}"
  end
end


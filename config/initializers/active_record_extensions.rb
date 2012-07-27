class ActiveRecord::Base
  # Helper to add errors on nested resources
  #
  # Example:
  #   user.errors_on_group(:articles, :title, user.articles, "must not contain foobar")
  def errors_on_group(group, attribute, children, message = "")
    errors[:"#{group}.#{attribute}"] = message
    children.each { |child| child.errors[attribute] = message }
  end
end

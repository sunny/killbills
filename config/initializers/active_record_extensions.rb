class ActiveRecord::Base
  # Helper to add errors on children
  def errors_on_group(group, attribute, children, message = "")
    errors[:"#{group}.#{attribute}"] = message
    children.each { |child| child.errors[attribute] = message }
  end
end

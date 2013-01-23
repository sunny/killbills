module ActiveRecord
  class Base
    # Adds errors on nested resources
    #
    # Example:
    #   user.errors_on_group(:articles, :title, user.articles, "must not contain foobar")
    def errors_on_group(group, attribute, children, message = "")
      errors[:"#{group}.#{attribute}"] = message
      children.each { |child| child.errors[attribute] = message }
    end
  end

  class Relation
    # Saves all records updated_at/on attributes set to the current time if they
    # match a set of conditions supplied.
    # Please note that no validation is performed and no callbacks are executed.
    # If an attribute name is passed, that attribute is updated along with
    # updated_at/on attributes.
    #
    # ==== Parameters
    #
    # * +conditions+ - Conditions are specified the same way as with +find+ method.
    # * +name+ - Additional name of attribute to update.
    #
    # ==== Examples
    #
    #   # Updates updated_at/on
    #   Product.visible.touch_all("category = 'Design'")
    #
    #   # Updates the designed_on attribute and updated_at/on
    #   Product.visible.touch_all("category = 'Design'", :designed_on)
    def touch_all(conditions = {}, name = nil)
      attributes = [:updated_at, :updated_on].select { |c| column_names.include?(c.to_s) }
      attributes << name if name

      unless attributes.empty?
        current_time = default_timezone == :utc ? Time.now.utc : Time.now
        changes = {}

        attributes.each do |column|
          changes[column.to_s] = current_time
        end

        self.update_all(changes, conditions) == 1
      end
    end
  end

end

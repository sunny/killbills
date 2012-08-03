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
    #   Products.touch_all("category = 'Design'")
    #
    #   # Updates the designed_on attribute and updated_at/on
    #   Products.touch_all("category = 'Design'", :designed_on)
    def touch_all(conditions = {}, name = nil)
      attributes = [:created_at, :created_on].select { |c| column_names.include?(c.to_s) }
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

  class Associations::Builder::HasMany
    def valid_options
      super + [:primary_key, :dependent, :as, :through, :source, :source_type, :inverse_of, :touch]
    end

    def build
      reflection = super
      add_touch_callbacks if options[:touch]
      configure_dependency
      reflection
    end

    private

      def add_touch_callbacks
        name        = self.name
        method_name = "has_many_touch_after_save_or_destroy_for_#{name}"
        touch       = options[:touch]

        mixin.redefine_method(method_name) do
          records = send(name)

          unless record.nil?
            if touch == true
              records.touch_all
            else
              records.touch_all(touch)
            end
          end
        end

        model.after_save(method_name)
        model.after_touch(method_name)
        model.after_destroy(method_name)
      end
  end
end

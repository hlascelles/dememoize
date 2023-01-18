# frozen_string_literal: true

require "dememoize/version"
require "dememoize/rspec_dememoize"

module Dememoize
  def dememoize(obj, *instance_variables)
    use_names = if instance_variables.empty?
                  obj.instance_variables
                else
                  instance_variables
                end
    use_names.each do |name|
      remove_instance_variable_if_defined(obj, name)
    end
  end

  def remove_instance_variable_if_defined(obj, name)
    return unless obj.instance_variable_defined?(name)

    obj.remove_instance_variable(name)
  end

  module_function :dememoize, :remove_instance_variable_if_defined
end

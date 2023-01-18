# frozen_string_literal: true

return unless Gem.loaded_specs["rspec"]

require "rspec/core"

module RSpec
  module Dememoize
    class << self
      def included(base)
        base.extend Dememoize
      end
    end
  end
end

RSpec.shared_context "with dememoized variable" do |name, object:|
  around(:each) do |example|
    Dememoize.remove_instance_variable_if_defined(object, name)
    example.run
    Dememoize.remove_instance_variable_if_defined(object, name)
  end
end

RSpec.shared_context "with dememoized class variable" do |name, clazz: described_class|
  around(:each) do |example|
    Dememoize.remove_instance_variable_if_defined(clazz, name)
    example.run
    Dememoize.remove_instance_variable_if_defined(clazz, name)
  end
end

RSpec.configure do |config|
  config.include RSpec::Dememoize
end

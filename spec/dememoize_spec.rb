# frozen_string_literal: true

require "spec_helper"

describe Dememoize do
  it "has a version number" do
    expect(Dememoize::VERSION).not_to be_nil
  end

  describe ".dememoize" do
    let(:instance) {
      Class.new do
        def initialize
          @foo = :foo
          @bar = :bar
          @baz = :baz
        end
      end.new
    }

    it "removes all instance variables" do
      described_class.dememoize(instance)

      expect(instance.instance_variables).to eq []
    end

    it "removes only the specified instance variables" do
      described_class.dememoize(instance, :@foo, :@baz)

      expect(instance.instance_variables).to eq [:@bar]
    end

    it "removes the specified instance variable if it is a string" do
      described_class.dememoize(instance, "@foo", "@baz")

      expect(instance.instance_variables).to eq [:@bar]
    end

    it "doesn't error if the instance variable doesn't exist" do
      expect { described_class.dememoize(instance, :@qux) }.not_to raise_error
      expect(instance.instance_variables).to match_array [:@bar, :@baz, :@foo]
    end
  end

  describe ".remove_instance_variable_if_defined" do
    let(:instance) {
      Class.new do
        def initialize
          @foo = :foo
        end
      end.new
    }

    it "removes the instance variable if defined" do
      described_class.remove_instance_variable_if_defined(instance, :@foo)

      expect(instance.instance_variables).to eq []
    end

    it "does not remove the instance variable if not defined" do
      described_class.remove_instance_variable_if_defined(instance, :@bar)

      expect(instance.instance_variables).to eq [:@foo]
    end
  end
end

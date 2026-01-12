# frozen_string_literal: true

require "spec_helper"

# rubocop:disable Lint/EmptyClass
class SomeTestClass
end

class SomeOtherTestClass
end
# rubocop:enable Lint/EmptyClass

SOME_INSTANCE = SomeTestClass.new

# rubocop:disable RSpec/BeforeAfterAll
# rubocop:disable RSpec/DescribeClass
describe "rspec_dememoize" do
  context "when with dememoized class variable" do
    describe SomeTestClass do
      include_context "with dememoized class variable", :@foo

      before(:each) do
        expect(described_class.instance_variable_defined?(:@foo)).to be false
      end

      after(:all) do # Must be after all to allow cleanup to happen
        expect(described_class.instance_variable_defined?(:@foo)).to be false
      end

      it "removes the instance variable after the example" do
        described_class.instance_variable_set(:@foo, "hello")
        expect(described_class.instance_variable_defined?(:@foo)).to be true
      end
    end

    context "when specifying the class" do
      include_context "with dememoized class variable", :@foo, clazz: SomeOtherTestClass

      before(:each) do
        expect(SomeOtherTestClass.instance_variable_defined?(:@foo)).to be false
      end

      after(:all) do # Must be after all to allow cleanup to happen
        expect(SomeOtherTestClass.instance_variable_defined?(:@foo)).to be false
      end

      it "removes the instance variable after the example" do
        SomeOtherTestClass.instance_variable_set(:@foo, "hello")
        expect(SomeOtherTestClass.instance_variable_defined?(:@foo)).to be true
      end
    end
  end

  context "when with dememoized variable" do
    include_context "with dememoized variable", :@foo, object: SOME_INSTANCE

    before(:each) do
      expect(SOME_INSTANCE.instance_variable_defined?(:@foo)).to be false
    end

    after(:all) do # Must be after all to allow cleanup to happen
      expect(SOME_INSTANCE.instance_variable_defined?(:@foo)).to be false
    end

    it "removes the instance variable after the example" do
      SOME_INSTANCE.instance_variable_set(:@foo, "hello")
      expect(SOME_INSTANCE.instance_variable_defined?(:@foo)).to be true
    end
  end
end
# rubocop:enable RSpec/DescribeClass
# rubocop:enable RSpec/BeforeAfterAll

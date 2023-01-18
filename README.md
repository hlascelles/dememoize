dememoize
=========

[![Gem Version](https://img.shields.io/gem/v/dememoize?color=green)](https://img.shields.io/gem/v/dememoize?color=green)

## Description

`dememoize` is a gem that provides a way to remove a memoized value (an instance variable) from a
class or an object instance.

The primary use case is usage in spec tests. If you have a code that memoizes a value, but you
would like to check that the value is calculated differently under different circumstances, you can
use `dememoize` to remove the memoized value, leaving you free to add another spec that can check
the value again. There are rspec shared contexts that can help you with this.

eg:

```ruby
class Product
  class << self 
    def categories
      @categories ||= expensive_calculation
    end
  end
end

describe "test different memoized values based on environment" do
  # Here is the shared_context that dememoize provides that aids with the specs
  include_context "with dememoized class variable", :@categories
  
  it "should return one value for prelive" do
    expect(Rails).to receive(:env).and_return("prelive")
    expect(Product.categories).to eq(1)
  end
  
  it "should return another value for production" do
    expect(Rails).to receive(:env).and_return("production")
    expect(Product.categories).to eq(2)
  end
end
```

## Installation

Add this line to your application's Gemfile, probably in the `:test` group:

```ruby
group :test do
  gem "dememoize"
end
```

## Simple usage

You can dememoize an instance:

```ruby
class Car
  def bolts
    @bolts ||= expensive_calculation
  end
end

car = Car.new
car.bolts # => 28376
car.dememoize(:@bolts)
car.instance_variable_defined?(:@bolts) # => false

# You can also specify the instance variable name as a string
car.bolts # => 28376
car.dememoize("@bolts")
car.instance_variable_defined?(:@bolts) # => false
```

You can dememoize a class variable:

```ruby
class Product
  class << self
    def categories
      @categories ||= expensive_calculation
    end
  end
end

Product.categories # => 4324
Product.dememoize(:@categories)
Product.instance_variable_defined?(:@categories) # => false
```

## Usage with RSpec

`dememoize` comes with rspec context helpers to dememoize a class variable in a spec:

```ruby
# In this example, dememoize assumes that the class under test is the object that should have the
# class instance variable removed.
describe "without specifying a class it uses described_class" do
  include_context "with dememoized class variable", :@categories
  
  it "should return one value for prelive" do
    expect(Rails).to receive(:env).and_return("prelive")
    expect(Product.categories).to eq(1234)
  end
  
  it "should return another value for production" do
    expect(Rails).to receive(:env).and_return("production")
    expect(Product.categories).to eq(5678)
  end
end

# If you want to dememoize a class variable on a different class, you can pass the class as the
# first argument to dememoized.

describe "specify a different class (Bar) to dememoize" do
  include_context "with dememoized class variable", :@categories, Bar # <-- Bar is the class
  # ...
end
```

## Upgrading

`dememoize` uses [semantic versioning](https://semver.org/), so major version changes will usually 
require additional actions to be taken upgrading from one major version to another. 

## Changelog

A full changelog can be found here: [CHANGELOG.md](https://github.com/hlascelles/dememoize/blob/master/CHANGELOG.md)

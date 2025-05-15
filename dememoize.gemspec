# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dememoize/version"

Gem::Specification.new do |spec|
  # rubocop:disable Layout/HashAlignment
  spec.name          = "dememoize"
  spec.version       = Dememoize::VERSION
  spec.authors       = ["Harry Lascelles"]
  spec.email         = ["harry@harrylascelles.com"]

  spec.summary       = "A gem to clean up memoization"
  spec.description   = <<~MSG
    A gem to clean up memoization. This is useful for testing, where you want to
    ensure that a method is called again after a change to the object.
  MSG
  spec.homepage      = "https://github.com/hlascelles/dememoize"
  spec.license       = "MIT"
  spec.metadata      = {
    "homepage_uri"      => "https://github.com/hlascelles/dememoize",
    "documentation_uri" => "https://github.com/hlascelles/dememoize",
    "changelog_uri"     => "https://github.com/hlascelles/dememoize/blob/master/CHANGELOG.md",
    "source_code_uri"   => "https://github.com/hlascelles/dememoize/",
    "bug_tracker_uri"   => "https://github.com/hlascelles/dememoize/issues",
    "rubygems_mfa_required" => "true",
  }

  spec.files = Dir["{lib}/**/*"] + ["README.md"]
  spec.require_paths = ["lib"]
  # rubocop:enable Layout/HashAlignment
end

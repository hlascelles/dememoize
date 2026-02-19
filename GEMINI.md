# Dememoize Development Guide

## Project Overview
`dememoize` is a Ruby gem designed to remove memoized instance variables from classes or objects. It is primarily used in testing (specifically with RSpec) to ensure that memoized values are recalculated under different test conditions.

## Core Components
- **`Dememoize` Module (`lib/dememoize.rb`)**: Contains the core logic for removing instance variables.
    - `dememoize(obj, *instance_variables)`: Removes specified instance variables (or all if none specified) from the given object.
    - `remove_instance_variable_if_defined(obj, name)`: Safely removes a specific instance variable if it exists.
- **RSpec Helpers (`lib/dememoize/rspec_dememoize.rb`)**: Provides shared contexts for RSpec tests.
    - `include_context "with dememoized variable", :@name, object: my_obj`
    - `include_context "with dememoized class variable", :@name, clazz: MyClass` (defaults to `described_class`)

## Development Workflow

### Prerequisites
- Ruby 3.3+ (Targeted in RuboCop and CI)
- Bundler

### Setup
```bash
bundle install
```

### Running Tests
Use the `specs.sh` script to run the full RSpec suite:
```bash
./specs.sh
```

### Quality Checks
The project enforces strict quality standards using RuboCop, Fasterer, and Reek. Use `quality.sh` to run all checks:
```bash
./quality.sh
```

### CI
GitHub Actions (`.github/workflows/specs.yml`) runs tests and quality checks against Ruby versions 3.3, 3.4, and 4.0.

## Project Structure
- `lib/`: Source code.
- `spec/`: RSpec tests.
- `quality.sh`: Runs RuboCop, Fasterer, and Reek.
- `specs.sh`: Runs RSpec.
- `dememoize.gemspec`: Gem configuration.
- `CHANGELOG.md`: Project history (needs manual updates during releases).

## Style & Conventions
- **RuboCop**: Follow the project's RuboCop configuration (`.rubocop.yml`).
- **RSpec**: All new features must include comprehensive RSpec tests in the `spec/` directory.
- **Versioning**: Follow [Semantic Versioning](https://semver.org/). Version is defined in `lib/dememoize/version.rb`.
- **Gemspec**: Never put a ruby requirement in the gemspec, leave that up to the end user to check.

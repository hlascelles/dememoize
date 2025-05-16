#! /usr/bin/env bash
set -euo pipefail

cd $(dirname $0)
bundle check || bundle install
bundle exec rspec

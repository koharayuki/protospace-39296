#!/usr/bin/env bash chmod +x ./bin/render-build.sh
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate


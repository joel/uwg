#!/usr/bin/env sh

set -e

echo "BUNDLER_VERSION: [$BUNDLER_VERSION]"
echo "BUNDLE_PATH: [$BUNDLER_PATH]"
echo "GEM_HOME: [$GEM_HOME]"
echo "BUNDLE_JOBS: [$BUNDLE_JOBS]"
echo "BUNDLE_RETRY: [$BUNDLE_RETRY]"
echo "BUNDLE_WITHOUT: [$BUNDLE_WITHOUT]"
echo "BUNDLE_CACHE_ALL: [$BUNDLE_CACHE_ALL]"
echo "RAILS_ENV: [$RAILS_ENV]"
echo "RACK_ENV: [$RACK_ENV]"
echo "APP_PATH: [$APP_PATH]"
echo "RAILS_LOG_TO_STDOUT: [$RAILS_LOG_TO_STDOUT]"

(bundle check || bundle install)

exec "$@"

#!/bin/bash

set -e

function run_integration_tests() {
  echo RUNNING INTEGRATION TESTS
}

function deploy() {
  echo DEPLOYING
}

function run_system_tests() {
  echo RUNNING SYSTEM TESTS
}

if [ ! -z "$DRONE_PR" ]; then
  # don't do a full pipeline for pull requests!!!!!!!!!!!!!!!
  run_integration_tests
  exit 0
fi

case "$DRONE_BRANCH" in
  develop)
    run_integration_tests
    git push origin $COMMIT:deploy
    ;;
  deploy)
    deploy
    git push origin $COMMIT:system-tests
    ;;
  system-tests)
    run_system_tests
    git push origin $COMMIT:master
    ;;
esac

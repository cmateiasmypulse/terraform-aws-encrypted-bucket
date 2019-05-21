#!/usr/bin/env bash

[ -n "$DEBUG" ] && set -x
set -e
set -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/../../.." && pwd )"

cd "$PROJECT_DIR"

set +e
openssl aes-256-cbc \
    -d \
    -in ./.circleci/gpg.private.enc -K "${ENCRYPTION_PASSPHRASE}" | gpg --import -
set -e

git crypt unlock

./go test:integration

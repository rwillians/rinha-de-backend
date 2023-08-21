#!/usr/bin/env bash
set -eEuo pipefail

RUNNER_TOKEN=$(curl -s -X POST -H "authorization: token ${GITHUB_PAT}" "https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token" | jq -r .token)

cleanup() {
  ./config.sh remove --token "${RUNNER_TOKEN}"
}

./config.sh \
  --url "https://github.com/${OWNER}/${REPO}" \
  --token "${RUNNER_TOKEN}" \
  --name "${NAME}" \
  --unattended \
  --work _work

./runsvc.sh

cleanup

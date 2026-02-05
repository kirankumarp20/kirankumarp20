#!/usr/bin/env bash
set -euo pipefail

if [[ -f config/local.env ]]; then
  # shellcheck disable=SC1091
  source config/local.env
else
  # shellcheck disable=SC1091
  source config/example.env
fi

require_cmd() {
  local cmd=$1
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Missing required command: ${cmd}" >&2
    exit 1
  fi
}

ensure_dir() {
  local dir=$1
  mkdir -p "${dir}"
}

log_path() {
  local dataset=$1
  local step=$2
  echo "${LOG_DIR}/${dataset}/${step}.log"
}

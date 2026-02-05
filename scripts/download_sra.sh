#!/usr/bin/env bash
set -euo pipefail

DATASET=${1:?"Usage: download_sra.sh <SRA_ACCESSION>"}

# shellcheck disable=SC1091
source scripts/common.sh

require_cmd prefetch
require_cmd fasterq-dump

ensure_dir "${DATA_DIR}/${DATASET}"
ensure_dir "${SRA_CACHE}"
ensure_dir "${SRA_TMP}"
ensure_dir "${LOG_DIR}/${DATASET}"

LOG_FILE=$(log_path "${DATASET}" "download")

echo "[download] prefetch ${DATASET}" | tee "${LOG_FILE}"
prefetch "${DATASET}" --output-directory "${SRA_CACHE}" 2>&1 | tee -a "${LOG_FILE}"

echo "[download] fasterq-dump ${DATASET}" | tee -a "${LOG_FILE}"
fasterq-dump "${SRA_CACHE}/${DATASET}" \
  --outdir "${DATA_DIR}/${DATASET}" \
  --temp "${SRA_TMP}" \
  --threads "${THREADS}" \
  2>&1 | tee -a "${LOG_FILE}"

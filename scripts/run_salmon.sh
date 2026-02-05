#!/usr/bin/env bash
set -euo pipefail

DATASET=${1:?"Usage: run_salmon.sh <SRA_ACCESSION>"}

# shellcheck disable=SC1091
source scripts/common.sh

require_cmd salmon

ensure_dir "${RESULTS_DIR}/quant/${DATASET}"
ensure_dir "${LOG_DIR}/${DATASET}"

LOG_FILE=$(log_path "${DATASET}" "salmon")

R1="${RESULTS_DIR}/trim/${DATASET}/${DATASET}_1.trim.fastq.gz"
R2="${RESULTS_DIR}/trim/${DATASET}/${DATASET}_2.trim.fastq.gz"

salmon quant \
  -i "${SALMON_INDEX}" \
  -l A \
  -1 "${R1}" \
  -2 "${R2}" \
  -p "${THREADS}" \
  -o "${RESULTS_DIR}/quant/${DATASET}" \
  2>&1 | tee "${LOG_FILE}"

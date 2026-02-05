#!/usr/bin/env bash
set -euo pipefail

DATASET=${1:?"Usage: run_fastp.sh <SRA_ACCESSION>"}

# shellcheck disable=SC1091
source scripts/common.sh

require_cmd fastp

ensure_dir "${RESULTS_DIR}/trim/${DATASET}"
ensure_dir "${LOG_DIR}/${DATASET}"

LOG_FILE=$(log_path "${DATASET}" "fastp")

R1="${DATA_DIR}/${DATASET}/${DATASET}_1.fastq"
R2="${DATA_DIR}/${DATASET}/${DATASET}_2.fastq"

fastp \
  --in1 "${R1}" \
  --in2 "${R2}" \
  --out1 "${RESULTS_DIR}/trim/${DATASET}/${DATASET}_1.trim.fastq.gz" \
  --out2 "${RESULTS_DIR}/trim/${DATASET}/${DATASET}_2.trim.fastq.gz" \
  --thread "${THREADS}" \
  --html "${RESULTS_DIR}/trim/${DATASET}/fastp.html" \
  --json "${RESULTS_DIR}/trim/${DATASET}/fastp.json" \
  2>&1 | tee "${LOG_FILE}"

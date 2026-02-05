#!/usr/bin/env bash
set -euo pipefail

DATASET=${1:?"Usage: run_fastqc.sh <SRA_ACCESSION>"}

# shellcheck disable=SC1091
source scripts/common.sh

require_cmd fastqc
require_cmd multiqc

ensure_dir "${RESULTS_DIR}/qc/${DATASET}"
ensure_dir "${LOG_DIR}/${DATASET}"

LOG_FILE=$(log_path "${DATASET}" "fastqc")

fastqc -t "${THREADS}" -o "${RESULTS_DIR}/qc/${DATASET}" \
  "${DATA_DIR}/${DATASET}"/*.fastq* 2>&1 | tee "${LOG_FILE}"

multiqc "${RESULTS_DIR}/qc/${DATASET}" \
  --outdir "${RESULTS_DIR}/qc/${DATASET}" 2>&1 | tee -a "${LOG_FILE}"

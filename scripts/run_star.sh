#!/usr/bin/env bash
set -euo pipefail

DATASET=${1:?"Usage: run_star.sh <SRA_ACCESSION>"}

# shellcheck disable=SC1091
source scripts/common.sh

require_cmd STAR

ensure_dir "${RESULTS_DIR}/align/${DATASET}"
ensure_dir "${LOG_DIR}/${DATASET}"

LOG_FILE=$(log_path "${DATASET}" "star")

R1="${RESULTS_DIR}/trim/${DATASET}/${DATASET}_1.trim.fastq.gz"
R2="${RESULTS_DIR}/trim/${DATASET}/${DATASET}_2.trim.fastq.gz"

STAR \
  --runThreadN "${THREADS}" \
  --genomeDir "${STAR_INDEX}" \
  --readFilesIn "${R1}" "${R2}" \
  --readFilesCommand zcat \
  --outSAMtype BAM SortedByCoordinate \
  --outFileNamePrefix "${RESULTS_DIR}/align/${DATASET}/${DATASET}." \
  2>&1 | tee "${LOG_FILE}"

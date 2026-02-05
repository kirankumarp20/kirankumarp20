SHELL := /usr/bin/env bash

PROJECT_ROOT := $(PWD)
ENV_FILE := config/local.env

ifneq (,$(wildcard $(ENV_FILE)))
  include $(ENV_FILE)
  export
else
  include config/example.env
  export
endif

DATASET ?= SRR00000000

.PHONY: help download qc trim align quantify all

help:
	@echo "Targets: download qc trim align quantify all"

all: download qc trim align quantify


download:
	@scripts/download_sra.sh $(DATASET)

qc:
	@scripts/run_fastqc.sh $(DATASET)

trim:
	@scripts/run_fastp.sh $(DATASET)

align:
	@scripts/run_star.sh $(DATASET)

quantify:
	@scripts/run_salmon.sh $(DATASET)

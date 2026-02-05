# High-performance RNA-seq development pipeline (low-level)

This repository provides a **low-level, high-performance RNA-seq pipeline** built from composable shell scripts and a Makefile. It is designed for **publicly available biological data** (e.g., SRA) and focuses on predictable performance, reproducibility, and transparency of each step.

## Goals

- **Low-level control**: Each stage is an explicit script that can be profiled and optimized independently.
- **High-performance**: Parallelism and efficient I/O are emphasized throughout the workflow.
- **Public data ready**: Includes SRA download and metadata capture.

## Pipeline overview

1. **Fetch public data** (SRA) using `prefetch` and `fasterq-dump`.
2. **Quality control** using `fastqc` and summary via `multiqc`.
3. **Adapter/quality trimming** with `fastp`.
4. **Alignment** with `STAR`.
5. **Quantification** with `salmon` (alignment-based or transcriptome mode).

## Requirements

Install the tools below (via conda/mamba, spack, or system packages):

- SRA Toolkit (`prefetch`, `fasterq-dump`)
- `fastqc`
- `multiqc`
- `fastp`
- `STAR`
- `salmon`

Optional for advanced profiling:
- `pigz` for faster compression
- `time`, `perf`, or `hyperfine` for benchmarking

## Quick start

1. Copy the example config and edit paths.

```bash
cp config/example.env config/local.env
```

2. Download a public dataset and run the pipeline:

```bash
make DATASET=SRR12345678 download
make DATASET=SRR12345678 qc
make DATASET=SRR12345678 trim
make DATASET=SRR12345678 align
make DATASET=SRR12345678 quantify
```

> Replace `SRR12345678` with the accession you want to process.

## Configuration

See `config/example.env` for paths and resource defaults. The Makefile reads `config/local.env` if present.

## Performance notes

- All scripts are **thread-aware**; tune `THREADS` for your machine.
- Use **local SSD** for `data/` to reduce I/O overhead.
- Keep reference files (genome, indexes) **local and cached**.

## Structure

```
config/   # environment defaults
scripts/  # low-level pipeline steps
results/  # outputs by step
logs/     # logs by step
```

## License

This project is provided as-is for development use.

# Project Notes: AirDNA Size Fractions

## Scope
This repository is maintained as a focused analysis project for the airborne eDNA size-fraction manuscript. The core objective is to reproduce manuscript figures and statistical outputs from processed sequencing tables, metadata, Biotrack optical data, and weather/deposition context data that are already included in the repo.

The analysis entrypoint is:
- `Scripts/Data_analysis.Rmd`

## Scientific background summary
The manuscript analyzes airborne eDNA collected at Hyltemossa across seasonal campaigns and aerodynamic size fractions. The key analytical questions are:
- How OTU richness and composition vary across filter size classes.
- How patterns differ between fall and spring sampling periods.
- How molecular signals align with optical bioaerosol measurements (Biotrack) in matching size classes.
- How local meteorology and size-dependent dry deposition behavior provide physical context for observed biological patterns.

## Expected input data for the manuscript analysis
The following repository files are treated as core inputs for the focused manuscript workflow:
- `Data/COI_ASW_glom.txt`
- `Data/COI_taxa_80_glom.txt`
- `Data/COI_Sintax_prob.txt`
- `Data/sample_meta.tsv`
- `Data/DNA_concentration_HS.txt`
- `Data/Hyltemossa_20201006.xlsx`
- `Data/Hyltemossa_20201022.xlsx`
- `Data/Hyltemossa_20210428.xlsx`
- `Data/Hyltemossa_20210524.xlsx`
- `Data/ICOS/SE-Htm_meteo_2020_CP_flag.txt`
- `Data/ICOS/My data cart/ICOS_ATC_NRT_HTM_2021-02-01_2022-02-28_30.0_612.MTO`
- `Data/deposition_speed.txt`

## Analysis style and coding instructions for future updates
When updating manuscript scripts in this project:
- Keep the workflow linear and analysis-focused (one-time ecological analysis style).
- Prefer direct file reads from repository paths.
- Do not add defensive schema checks for missing columns; fix metadata upstream instead.
- Use tidyverse pipes and readable object names.
- Keep code chunks brief and separate analytical steps clearly.
- Add clear markdown between chunks that explains analytical purpose and choice rationale.
- Emphasize what each analysis evaluates and why it matters for interpretation.
- Save intermediate tables as TSV in `Data/derived/` where useful.
- Save final figures to a clearly named folder under `Figures/`.
- Prioritize clarity and reproducibility over abstraction or engineering-heavy patterns.

## Non-scope notes
- Raw sequencing and full amplicon pipeline assets can exist in the broader project context, but this manuscript repository should stay focused on size-fraction analysis deliverables.
- DADA2/amplicon preprocessing is treated as complete and not modified in the manuscript analysis script.

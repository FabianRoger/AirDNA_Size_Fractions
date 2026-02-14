# AirDNA Size Fractions

This repository contains the code and data used for the manuscript-focused analysis of **size-fractionated airborne eDNA** samples.

## Project Overview

The study analyzes airborne eDNA collected at Hyltemossa (southern Sweden) using a multi-stage impactor (NGI) and COI metabarcoding to evaluate how biodiversity signal varies across particle-size fractions.

The repository is organized to run the manuscript analysis directly from local files.

## Study Setup (Manuscript Scope)

- Site: Hyltemossa Aerosol Research Station, southern Sweden
- Sampling design: size-fractionated NGI samples across fall and spring campaigns
- Molecular marker: COI (Leray primer set)
- Downstream focus: diversity, taxonomic composition, and size-fraction patterns

## Analysis Entrypoint

Primary script for manuscript analyses:

- `Scripts/Data_analysis.Rmd`

This script is configured to read local metadata by default (`Data/sample_meta.tsv`).

Optional metadata refresh from Google Sheets can be enabled only when needed:

```bash
REFRESH_SAMPLE_META=true Rscript -e "rmarkdown::render('Scripts/Data_analysis.Rmd')"
```

Default local run:

```bash
Rscript -e "rmarkdown::render('Scripts/Data_analysis.Rmd')"
```

## Required Input Data for `Data_analysis.Rmd`

Core metabarcoding inputs:

- `Data/COI_ASW_glom.txt`
- `Data/COI_taxa_80_glom.txt`
- `Data/COI_Sintax_prob.txt`
- `Data/DNA_concentration_HS.txt`
- `Data/sample_meta.tsv`

Biotrack and weather/deposition inputs used in later sections:

- `Data/Hyltemossa_20201006.xlsx`
- `Data/Hyltemossa_20201022.xlsx`
- `Data/Hyltemossa_20210428.xlsx`
- `Data/Hyltemossa_20210524.xlsx`
- `Data/Matched_DNA_Biotrack.txt`
- `Data/ICOS/SE-Htm_meteo_2020_CP_flag.txt`
- `Data/ICOS/My data cart/ICOS_ATC_NRT_HTM_2021-02-01_2022-02-28_30.0_612.MTO`
- `Data/deposition_speed.txt`

## Expected Outputs

`Scripts/Data_analysis.Rmd` generates manuscript figures and derived tables (for example in `Figures/` and selected `Data/*.txt` outputs).

## Manuscript Draft

The current manuscript draft used for repository alignment is stored at:

- `Documents/AirDNA_size_fraction.md`

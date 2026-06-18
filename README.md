# r-you-ok

A structured R learning curriculum built from zero — no prior R experience assumed.
Concepts are introduced progressively, anchored to real data throughout.

---

## Environment

This repo was built and tested on:

- **macOS** 12.7.2 Monterey (Intel x86_64)
- **R** 4.4.1 — [CRAN Intel Mac archive](https://cran.r-project.org/bin/macosx/big-sur-x86_64/base/)
- **RStudio Desktop** 2024.09.1+394 — [Posit supported versions](https://docs.posit.co/supported-versions/rstudio.html)

> If you are on Apple Silicon (M1/M2/M3), download the arm64 build of R instead.
> Match your RStudio version to your macOS version using the Posit supported versions page.

---

## Installation

### 1. Install R

Download the `.pkg` for your architecture from the CRAN link above and run the installer.

### 2. Install RStudio Desktop

Download from the Posit supported versions page — choose the build that matches your macOS version. Run the installer and open RStudio.

### 3. Install the tidyverse

In the RStudio console (bottom-left panel), run:

```r
install.packages("tidyverse")
```

This installs the core modern R toolkit: dplyr, ggplot2, tidyr, readr, and more.
It will take a few minutes on first install.

### 4. Verify

```r
library(tidyverse)
```

If it loads without errors, you are ready.

---

## Curriculum

| File | Stage | Topic |
|---|---|---|
| [lessons/01-how-r-thinks.R](lessons/01-how-r-thinks.R) | 1 | Vectors, types, vectorized operations |
| [lessons/02-data-structures.R](lessons/02-data-structures.R) | 2 | Vectors, lists, data frames, factors |
| [lessons/03-control-flow-functions.R](lessons/03-control-flow-functions.R) | 3 | if/else, loops, writing functions |
| [lessons/04-tidyverse-pipes.R](lessons/04-tidyverse-pipes.R) | 4 | The pipe, dplyr verbs, read_csv |
| [lessons/05-ggplot2-visualization.R](lessons/05-ggplot2-visualization.R) | 5 | Grammar of graphics, ggplot2 |
| [lessons/06-reading-writing-data.R](lessons/06-reading-writing-data.R) | 6 | CSV, JSON, file paths, missing data |
| [lessons/07-statistical-analysis.R](lessons/07-statistical-analysis.R) | 7 | Summary stats, correlation, regression, t-test |
| [lessons/08-project.R](lessons/08-project.R) | 8 | Build something from scratch |

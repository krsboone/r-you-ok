# Stage 6 — Reading and Writing Data
# Getting data in and out of R.
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)


# ── read_csv() / write_csv() ──────────────────────────────────────────────────

# Read a CSV into a tibble
df <- read_csv("path/to/close_events.csv")

# Common options:
df <- read_csv(
  "close_events.csv",
  skip    = 0,             # skip N rows at the top
  na      = c("", "NA"),   # treat these strings as missing
  comment = "#"            # ignore lines starting with #
)

# Inspect immediately after loading
glimpse(df)    # compact column overview — like str() but tidyverse-flavored
head(df)       # first 6 rows
tail(df)       # last 6 rows

# Write a tibble or data frame to CSV
write_csv(df, "output.csv")


# ── File paths ────────────────────────────────────────────────────────────────

# file.path() builds paths correctly across operating systems
path <- file.path("data", "close_events.csv")
path   # "data/close_events.csv"

# Check if a file exists before reading
file.exists(path)   # TRUE or FALSE

# List files in a directory
list.files("data/")
list.files("data/", pattern = "\\.csv$")   # only CSV files


# ── readLines() — raw text / JSON lines ──────────────────────────────────────

# readLines() reads a file as a character vector — one element per line.
# Useful for JSON lines format (one JSON object per line).

raw <- readLines("trades.jsonl")
raw[1]   # first line — a JSON string

# Parse JSON lines into a list of R objects
# install.packages("jsonlite") if not already installed
library(jsonlite)

records <- lapply(raw, fromJSON)   # parse each line
records[[1]]                       # first trade as an R list

# Convert to a data frame — works when all records have the same fields
trades_df <- bind_rows(lapply(raw, fromJSON))
trades_df


# ── Handling missing data ─────────────────────────────────────────────────────

df <- tibble(
  strategy = c("edge", "moon", NA, "straddle"),
  pnl      = c(0.05, NA, -0.12, 0.15)
)

# Check for NAs
is.na(df$pnl)           # logical vector
sum(is.na(df$pnl))      # count of missing values
colSums(is.na(df))      # count NAs per column

# Remove rows with any NA
na.omit(df)

# tidyverse approach — drop rows where pnl is NA
df |> filter(!is.na(pnl))

# Replace NAs with a default value
df |> mutate(pnl = replace_na(pnl, 0))

# Replace NAs using tidyr
df |> tidyr::replace_na(list(pnl = 0, strategy = "unknown"))


# ── Other file formats ────────────────────────────────────────────────────────

# Excel — requires the readxl package
# install.packages("readxl")
library(readxl)
# df <- read_excel("file.xlsx", sheet = "Sheet1")

# Tab-separated files
df <- read_tsv("file.tsv")

# Base R CSV reader (slower, returns data.frame not tibble, but no dependency)
df <- read.csv("file.csv")   # note: read.csv vs read_csv


# ── Practical pattern: load, clean, save ─────────────────────────────────────

# A typical pipeline:
#
# raw <- read_csv("close_events.csv")
#
# clean <- raw |>
#   filter(!is.na(pnl)) |>
#   mutate(date = as.Date(timestamp)) |>
#   select(date, strategy, pnl, win)
#
# write_csv(clean, "close_events_clean.csv")


# ── Exercises ─────────────────────────────────────────────────────────────────

# 1. Create a small tibble in R (4-5 rows, 3 columns) and write it to a CSV
#    with write_csv(). Then read it back with read_csv() and inspect with glimpse().

# 2. Using your tibble from above, introduce an NA into one column.
#    Count the NAs, then use filter(!is.na()) to remove incomplete rows.

# 3. Use file.path() to build a path to "data/trades.jsonl" and check
#    if it exists on your machine with file.exists().

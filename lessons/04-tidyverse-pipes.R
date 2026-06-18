# Stage 4 — The Tidyverse & Pipes
# Modern R data work. This is where R really shines.
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)


# ── The pipe operator |> ──────────────────────────────────────────────────────

# The pipe passes the result on the left as the first argument to the function
# on the right. It lets you chain operations into a readable sequence.

# Without pipe — reads inside-out, hard to follow:
round(mean(c(1, 2, 3, 4, 5)), 2)

# With pipe — reads left to right, top to bottom:
c(1, 2, 3, 4, 5) |> mean() |> round(2)

# The old tidyverse pipe was %>% (from the magrittr package).
# R 4.1+ has a native pipe |> built in. They behave the same in most cases.
# You will see both in the wild — they are interchangeable for our purposes.


# ── Sample data ───────────────────────────────────────────────────────────────

# We'll use this throughout Stage 4.
trades <- tibble(
  strategy = c("edge", "moon", "edge", "straddle", "moon", "edge", "straddle", "tail"),
  side     = c("YES", "YES", "NO",  "YES",       "NO",   "YES", "NO",        "YES"),
  price    = c(0.98,  0.12,  0.88,  0.55,        0.08,   0.95,  0.45,        0.30),
  pnl      = c(0.02,  0.88, -0.12,  0.15,       -0.08,   0.05,  0.10,       -0.30),
  win      = c(TRUE,  TRUE,  FALSE, TRUE,         FALSE,  TRUE,  TRUE,        FALSE)
)


# ── filter() — keep rows matching a condition ─────────────────────────────────

# Keep only winning trades
trades |> filter(win == TRUE)

# Keep trades from the "edge" strategy
trades |> filter(strategy == "edge")

# Multiple conditions — AND
trades |> filter(win == TRUE, pnl > 0.10)

# Multiple conditions — OR
trades |> filter(strategy == "edge" | strategy == "moon")

# Shorthand for OR with multiple values
trades |> filter(strategy %in% c("edge", "moon"))


# ── select() — keep specific columns ─────────────────────────────────────────

trades |> select(strategy, pnl)
trades |> select(-side)           # everything except 'side'
trades |> select(strategy:price)  # columns from strategy through price


# ── mutate() — add or transform columns ──────────────────────────────────────

# Add a column showing pnl as a percentage
trades |> mutate(pnl_pct = pnl * 100)

# Add a column classifying trade size
trades |> mutate(size = ifelse(abs(pnl) > 0.20, "large", "small"))

# Multiple mutations at once
trades |>
  mutate(
    pnl_pct = pnl * 100,
    result  = ifelse(win, "win", "loss")
  )


# ── arrange() — sort rows ─────────────────────────────────────────────────────

trades |> arrange(pnl)            # ascending (worst to best)
trades |> arrange(desc(pnl))      # descending (best to worst)
trades |> arrange(strategy, desc(pnl))  # sort by strategy, then by pnl within


# ── group_by() + summarize() — aggregate ─────────────────────────────────────

# This is the most powerful combination in dplyr.
# group_by() splits the data into groups, summarize() collapses each group.

trades |>
  group_by(strategy) |>
  summarize(
    trades     = n(),
    wins       = sum(win),
    win_rate   = mean(win),
    mean_pnl   = mean(pnl),
    total_pnl  = sum(pnl)
  )

# n() counts rows in each group — only valid inside summarize()/mutate()


# ── Chaining it all together ──────────────────────────────────────────────────

# This is what a real analysis looks like in R.
# Read it top to bottom like a sentence:

trades |>
  filter(win == TRUE) |>
  group_by(strategy) |>
  summarize(
    wins     = n(),
    mean_pnl = mean(pnl)
  ) |>
  arrange(desc(mean_pnl))


# ── read_csv() — loading real data ────────────────────────────────────────────

# readr::read_csv() is the tidyverse CSV reader (faster and cleaner than
# base R's read.csv()).

# df <- read_csv("path/to/your/file.csv")

# read_csv() returns a tibble and infers column types automatically.
# It prints a "column specification" message showing what it detected —
# this is informational, not an error.

# Useful options:
# read_csv("file.csv", skip = 1)          skip the first row
# read_csv("file.csv", na = c("", "NA"))  treat these as missing
# read_csv("file.csv", col_types = cols(price = col_double()))  force a type


# ── Exercises ─────────────────────────────────────────────────────────────────

# Using the trades tibble above:

# 1. Filter to trades where pnl > 0 AND price < 0.50 (longshots that paid off)

# 2. Add a column called 'edge' defined as abs(price - 0.50)
#    (how far from 50/50 the market was)

# 3. Group by strategy and calculate:
#    - number of trades
#    - win rate
#    - total pnl
#    Then arrange by total_pnl descending.

# 4. Chain: filter to losses only, then summarize mean loss per strategy

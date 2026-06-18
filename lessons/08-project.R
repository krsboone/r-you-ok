# Stage 8 — Project: Build Something
# You design and write it. I guide.
# ─────────────────────────────────────────────────────────────────────────────

# ── The brief ─────────────────────────────────────────────────────────────────

# Build a strategy performance report in R.
#
# Input:  close_events.csv (your real trading data)
# Output: a summary table + at least one ggplot2 visualization
#
# The report should answer:
#   - Which strategy has the best win rate?
#   - Which strategy has the highest mean P&L per trade?
#   - Which strategy has the best Sharpe-like ratio (mean / sd)?
#   - How does cumulative P&L evolve over time?
#
# No scaffolding provided here — write it from scratch using what you learned
# in Stages 1–7. Use the lesson files as reference.


# ── Concepts you'll need ──────────────────────────────────────────────────────

# Stage 6: read_csv() to load the data
# Stage 4: filter(), group_by(), summarize(), mutate(), arrange()
# Stage 5: ggplot2 for the visualization
# Stage 7: mean(), sd(), t.test() to assess edge


# ── Stretch goals (if you want more) ─────────────────────────────────────────

# - Add a t-test per strategy and flag which strategies have p-value < 0.05
# - Facet your plot by strategy using facet_wrap(~ strategy)
# - Save the summary table as a CSV with write_csv()
# - Save the plot with ggsave()


# ── Your code goes below ──────────────────────────────────────────────────────

library(tidyverse)

# Start here...

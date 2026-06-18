# Stage 5 — Visualization with ggplot2
# The grammar of graphics — build plots in layers.
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)


# ── The core idea ─────────────────────────────────────────────────────────────

# Every ggplot2 plot is built from three things:
#   1. Data       — the data frame you're plotting
#   2. Aesthetics — which columns map to x, y, color, size, etc.
#   3. Geom       — the visual shape (line, bar, point, histogram, etc.)

# ggplot(data) + aes(x = col, y = col) + geom_something()

# Layers are added with + (not |>)


# ── Sample data ───────────────────────────────────────────────────────────────

trades <- tibble(
  date     = as.Date(c("2026-06-01", "2026-06-02", "2026-06-03",
                       "2026-06-04", "2026-06-05", "2026-06-06",
                       "2026-06-07", "2026-06-08")),
  strategy = c("edge", "moon", "edge", "straddle", "moon", "edge", "straddle", "tail"),
  pnl      = c(0.02, 0.88, -0.12, 0.15, -0.08, 0.05, 0.10, -0.30),
  win      = c(TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE)
)

# Cumulative P&L over time
trades <- trades |> mutate(cumulative_pnl = cumsum(pnl))


# ── geom_line — line chart ────────────────────────────────────────────────────

ggplot(trades, aes(x = date, y = cumulative_pnl)) +
  geom_line()

# Add points on top of the line
ggplot(trades, aes(x = date, y = cumulative_pnl)) +
  geom_line() +
  geom_point()

# Color the points by win/loss
ggplot(trades, aes(x = date, y = cumulative_pnl)) +
  geom_line() +
  geom_point(aes(color = win), size = 3)


# ── geom_col — bar chart ──────────────────────────────────────────────────────

# Total P&L per strategy
summary_df <- trades |>
  group_by(strategy) |>
  summarize(total_pnl = sum(pnl))

ggplot(summary_df, aes(x = strategy, y = total_pnl)) +
  geom_col()

# Color bars by value (positive vs negative)
ggplot(summary_df, aes(x = strategy, y = total_pnl, fill = total_pnl > 0)) +
  geom_col()


# ── geom_point — scatter plot ────────────────────────────────────────────────

ggplot(trades, aes(x = date, y = pnl, color = strategy)) +
  geom_point(size = 3)


# ── geom_histogram — distribution ────────────────────────────────────────────

ggplot(trades, aes(x = pnl)) +
  geom_histogram(bins = 10)

# With color
ggplot(trades, aes(x = pnl, fill = win)) +
  geom_histogram(bins = 10, alpha = 0.7)   # alpha = transparency


# ── geom_boxplot — spread by group ───────────────────────────────────────────

ggplot(trades, aes(x = strategy, y = pnl)) +
  geom_boxplot()


# ── labs() — titles and labels ────────────────────────────────────────────────

ggplot(trades, aes(x = date, y = cumulative_pnl)) +
  geom_line() +
  geom_point() +
  labs(
    title    = "Cumulative P&L Over Time",
    subtitle = "All strategies combined",
    x        = "Date",
    y        = "Cumulative P&L ($)",
    caption  = "Source: trades data"
  )


# ── theme_minimal() — clean look ─────────────────────────────────────────────

# Themes control the non-data appearance (background, gridlines, fonts).
# theme_minimal() removes the grey background — a good default.

ggplot(trades, aes(x = date, y = cumulative_pnl)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(color = "steelblue", size = 2) +
  labs(title = "Cumulative P&L", x = "Date", y = "P&L") +
  theme_minimal()

# Other built-in themes: theme_classic(), theme_bw(), theme_light()


# ── Putting it all together ───────────────────────────────────────────────────

ggplot(trades, aes(x = date, y = pnl, color = strategy, shape = win)) +
  geom_point(size = 3) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  labs(
    title  = "Individual Trade P&L by Strategy",
    x      = "Date",
    y      = "P&L",
    color  = "Strategy",
    shape  = "Win"
  ) +
  theme_minimal()


# ── ggsave() — save a plot to disk ───────────────────────────────────────────

# Run the plot first, then ggsave() saves the most recent one.
ggsave("my_plot.png", width = 8, height = 5, dpi = 150)

# Or assign the plot to a variable and save it explicitly:
p <- ggplot(trades, aes(x = date, y = cumulative_pnl)) +
  geom_line() +
  theme_minimal()

ggsave("cumulative_pnl.png", plot = p, width = 8, height = 5)


# ── Exercises ─────────────────────────────────────────────────────────────────

# Using the trades data above:

# 1. Create a bar chart showing win count per strategy (use summarize + geom_col)

# 2. Create a scatter plot of date vs pnl, colored by strategy,
#    with a dashed horizontal line at y = 0

# 3. Add a title, axis labels, and theme_minimal() to the scatter plot

# 4. Save the scatter plot to disk with ggsave()

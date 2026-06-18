# Stage 7 — Statistical Analysis
# What R was built for.
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)


# ── summary() — the first thing to run on any data ───────────────────────────

pnl <- c(0.02, 0.88, -0.12, 0.15, -0.08, 0.05, 0.10, -0.30, 0.22, -0.05)

summary(pnl)
# Min.  1st Qu.  Median  Mean  3rd Qu.  Max.
# Gives you the five-number summary plus the mean in one shot.

trades <- tibble(
  strategy = c("edge","moon","edge","straddle","moon","edge","straddle","tail","edge","moon"),
  pnl      = pnl,
  win      = pnl > 0
)

summary(trades)   # summary applied to an entire data frame — per column


# ── Basic summary statistics ──────────────────────────────────────────────────

mean(pnl)               # average
median(pnl)             # middle value — less sensitive to outliers than mean
sd(pnl)                 # standard deviation
var(pnl)                # variance (sd squared)
min(pnl)                # minimum
max(pnl)                # maximum
range(pnl)              # c(min, max)
sum(pnl)                # total

quantile(pnl)           # 0%, 25%, 50%, 75%, 100%
quantile(pnl, 0.10)     # 10th percentile
quantile(pnl, c(0.25, 0.75))   # interquartile range endpoints

# All of these are vectorized — they work on the full vector
# and handle NA if you add na.rm = TRUE:
mean(c(1, 2, NA, 4), na.rm = TRUE)   # 2.33


# ── Grouped summary stats (with dplyr) ───────────────────────────────────────

trades |>
  group_by(strategy) |>
  summarize(
    n        = n(),
    win_rate = mean(win),
    mean_pnl = mean(pnl),
    sd_pnl   = sd(pnl),
    total    = sum(pnl),
    sharpe   = mean(pnl) / sd(pnl)   # simple Sharpe-like ratio
  ) |>
  arrange(desc(sharpe))


# ── Correlation ───────────────────────────────────────────────────────────────

x <- c(1, 2, 3, 4, 5)
y <- c(2.1, 3.9, 6.2, 8.1, 9.8)

cor(x, y)    # Pearson correlation coefficient — close to 1 means strong positive

# Correlation matrix for multiple columns
df <- tibble(a = rnorm(50), b = rnorm(50), c = rnorm(50))
cor(df)   # 3x3 correlation matrix


# ── Linear regression with lm() ──────────────────────────────────────────────

# lm(y ~ x, data = df) — fit a linear model
# Formula syntax: ~ means "is modeled by"

# Does entry price predict P&L?
prices_vec <- c(0.98, 0.12, 0.88, 0.55, 0.08, 0.95, 0.45, 0.30, 0.72, 0.15)
model <- lm(pnl ~ prices_vec)

summary(model)
# Key things to read in the output:
#   Estimate (Intercept)  — the y-intercept
#   Estimate prices_vec   — slope: how much pnl changes per unit of price
#   Pr(>|t|)              — p-value: is this coefficient significantly different from 0?
#   R-squared             — how much variance in pnl is explained by price (0–1)

# Multiple predictors
trades_num <- trades |> mutate(price = prices_vec)
model2 <- lm(pnl ~ price + win, data = trades_num)
summary(model2)


# ── t-test — is the mean different from zero? ────────────────────────────────

# The key question for any trading strategy:
# Is the mean P&L significantly positive, or could it be random noise?

t.test(pnl)
# Output to read:
#   t       — test statistic
#   df      — degrees of freedom
#   p-value — probability of seeing this result if the true mean were 0
#              p < 0.05 is the conventional threshold for "statistically significant"
#   95% CI  — confidence interval for the true mean
#   mean    — sample mean

# Interpreting: if p-value < 0.05, you have statistical evidence of edge.
# If p-value > 0.05, you can't rule out that results are due to chance.

# One-sided test — is the mean *greater than* zero?
t.test(pnl, alternative = "greater")

# Two-sample t-test — are two strategies different from each other?
edge_pnl <- trades |> filter(strategy == "edge") |> pull(pnl)
moon_pnl  <- trades |> filter(strategy == "moon") |> pull(pnl)
t.test(edge_pnl, moon_pnl)


# ── table() and prop.table() — frequency counts ──────────────────────────────

# Counts
table(trades$strategy)
table(trades$win)
table(trades$strategy, trades$win)   # two-way table (cross-tabulation)

# Proportions
prop.table(table(trades$strategy))
prop.table(table(trades$win))


# ── Exercises ─────────────────────────────────────────────────────────────────

# Using this P&L vector from a 30-trade sample:
sample_pnl <- c(0.05, -0.08, 0.15, 0.02, -0.12, 0.22, -0.03, 0.08,
                0.01, -0.15, 0.18, -0.02, 0.07, 0.11, -0.09, 0.04,
                -0.06, 0.13, 0.03, -0.11, 0.09, -0.04, 0.16, 0.02,
                -0.07, 0.14, -0.01, 0.06, 0.10, -0.08)

# 1. Calculate: mean, median, sd, and sum. What does the mean tell you?

# 2. Run a t-test. Is the mean P&L significantly greater than zero?
#    Report: the p-value, the 95% confidence interval, and your interpretation.

# 3. How many trades were wins (pnl > 0)? What's the win rate?
#    Use sum() and mean() on a logical vector.

# 4. Calculate a simple Sharpe ratio: mean(pnl) / sd(pnl)
#    A Sharpe > 0.5 is considered decent for a trading strategy.

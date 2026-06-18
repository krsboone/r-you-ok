# Stage 3 — Control Flow & Functions
# Writing logic and reusable code.
# ─────────────────────────────────────────────────────────────────────────────


# ── if / else ─────────────────────────────────────────────────────────────────

price <- 0.72

if (price > 0.90) {
  print("near-certain outcome")
} else if (price > 0.50) {
  print("favored outcome")
} else {
  print("longshot")
}

# ifelse() — vectorized version, works on an entire vector at once
prices <- c(0.98, 0.72, 0.45, 0.12, 0.88)
ifelse(prices > 0.50, "favored", "longshot")   # returns a character vector


# ── for loops ────────────────────────────────────────────────────────────────

# In R, explicit loops are less common than in Python because vectorized
# operations handle most cases. But loops exist and are sometimes the
# clearest way to express intent.

strategies <- c("edge", "moon", "tail", "straddle")

for (s in strategies) {
  cat("Processing strategy:", s, "\n")
}

# Looping with an index
for (i in 1:length(strategies)) {
  cat(i, "—", strategies[i], "\n")
}

# seq_along() is cleaner than 1:length() and avoids edge cases
for (i in seq_along(strategies)) {
  cat(i, "—", strategies[i], "\n")
}


# ── while loops ───────────────────────────────────────────────────────────────

count <- 0
while (count < 3) {
  cat("count is:", count, "\n")
  count <- count + 1
}


# ── Writing functions ─────────────────────────────────────────────────────────

# Functions are defined with function() and assigned like any other object.

win_rate <- function(wins, total) {
  wins / total
}

win_rate(7, 10)     # 0.7
win_rate(257, 320)  # 0.803

# Default arguments
win_rate_pct <- function(wins, total, decimals = 2) {
  rate <- wins / total * 100
  round(rate, decimals)
}

win_rate_pct(7, 10)          # 70    — uses default decimals = 2
win_rate_pct(7, 10, 4)       # 70.0000
win_rate_pct(7, 10, decimals = 0)  # 70 — named argument

# Return values — R returns the last evaluated expression automatically
# You can also use return() explicitly, which is clearer in complex functions

classify_price <- function(price) {
  if (price >= 0.90) return("near-certain")
  if (price >= 0.50) return("favored")
  return("longshot")
}

classify_price(0.98)   # "near-certain"
classify_price(0.72)   # "favored"
classify_price(0.12)   # "longshot"


# ── Scope ─────────────────────────────────────────────────────────────────────

# Variables created inside a function stay inside the function.
# The function can read variables from the outer environment,
# but should not rely on them — pass everything in as arguments.

x <- 100

add_to_x <- function(n) {
  x + n          # reads x from the outer environment — works, but fragile
}

add_to_x(5)   # 105

# Better — explicit:
add_values <- function(a, b) {
  a + b
}

add_values(x, 5)   # 105 — x passed in explicitly


# ── apply family — vectorized alternatives to loops ──────────────────────────

# sapply — apply a function to each element of a vector, return a vector
prices <- c(0.98, 0.72, 0.45, 0.12, 0.88)
sapply(prices, classify_price)   # applies classify_price to each price

# lapply — same but always returns a list
lapply(prices, classify_price)

# In practice, once you learn the tidyverse (Stage 4), you'll use
# purrr::map() instead, which is cleaner. But sapply/lapply appear
# everywhere in existing R code, so it's worth knowing them.


# ── Exercises ─────────────────────────────────────────────────────────────────

# 1. Write a function called sharpe_ratio(returns, risk_free = 0)
#    that returns mean(returns - risk_free) / sd(returns)
#    Test it with: sharpe_ratio(c(0.05, -0.02, 0.08, 0.03, -0.01))

# 2. Write a function called label_trade(pnl) that returns:
#    "win" if pnl > 0, "loss" if pnl < 0, "scratch" if pnl == 0

# 3. Use sapply() to apply label_trade to this vector:
#    pnl_values <- c(0.15, -0.08, 0.00, 0.22, -0.03)
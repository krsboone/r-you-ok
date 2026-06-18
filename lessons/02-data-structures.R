# Stage 2 — Data Structures
# What holds your data, and when to use each.
# ─────────────────────────────────────────────────────────────────────────────


# ── Vectors (revisited) ───────────────────────────────────────────────────────

# Vectors must hold a single type. If you mix types, R coerces everything
# to the most flexible type that fits all values.

c(1, 2, 3)           # numeric vector
c("a", "b", "c")     # character vector
c(TRUE, FALSE, TRUE) # logical vector

# Mixing types — R coerces silently:
c(1, 2, "three")     # "1" "2" "three" — all become character
c(1, TRUE, FALSE)    # 1 1 0 — logicals become numeric (TRUE=1, FALSE=0)

# Named vectors — attach names to elements
wins <- c(monday = 3, tuesday = 1, wednesday = 5)
wins["monday"]       # access by name
wins[["monday"]]     # same, but returns the value without the name label


# ── Lists ─────────────────────────────────────────────────────────────────────

# Lists can hold mixed types — including other lists.
# Think of them like Python dicts, but accessed by position OR name.

trade <- list(
  symbol   = "KXBTC15M",
  side     = "YES",
  price    = 0.72,
  quantity = 10,
  win      = TRUE
)

trade$symbol        # "KXBTC15M" — dollar sign accesses by name
trade[["price"]]    # 0.72      — double brackets returns the value
trade["side"]       # returns a list with one element (single brackets keep the wrapper)
trade[[4]]          # 10        — access by position

str(trade)          # inspect the whole structure


# ── Data Frames ───────────────────────────────────────────────────────────────

# The workhorse of R. A data frame is a table — columns of equal length,
# each column can be a different type.

trades <- data.frame(
  symbol   = c("KXBTC15M", "KXETH15M", "KXBTC15M"),
  side     = c("YES", "NO", "YES"),
  price    = c(0.72, 0.45, 0.88),
  quantity = c(10, 5, 8),
  win      = c(TRUE, FALSE, TRUE)
)

trades              # print the table
nrow(trades)        # number of rows
ncol(trades)        # number of columns
dim(trades)         # rows and columns together
str(trades)         # structure overview
head(trades)        # first 6 rows (useful for large datasets)
summary(trades)     # quick stats for each column

# Accessing columns
trades$price        # the price column as a vector
trades[["win"]]     # same thing, double bracket notation

# Accessing rows and cells — [row, column]
trades[1, ]         # first row, all columns
trades[, "price"]   # all rows, price column
trades[2, "symbol"] # row 2, symbol column

# Filtering rows
trades[trades$win == TRUE, ]     # only winning trades
trades[trades$price > 0.70, ]    # trades above 0.70


# ── Factors ───────────────────────────────────────────────────────────────────

# Factors represent categorical data with a fixed set of possible values (levels).
# R uses them for things like: strategy names, win/loss, market side.

side <- factor(c("YES", "NO", "YES", "YES", "NO"))
side            # shows values and levels
levels(side)    # "NO" "YES" — the distinct categories (sorted alphabetically)
table(side)     # count of each level — very handy

# Ordered factors — categories with a meaningful order
rating <- factor(c("low", "high", "medium", "high"),
                 levels = c("low", "medium", "high"),
                 ordered = TRUE)
rating
rating > "low"   # TRUE/FALSE comparisons work with ordered factors


# ── NA vs NULL ────────────────────────────────────────────────────────────────

# NA  = a missing value — the slot exists but the value is unknown
# NULL = the absence of an object — nothing is there at all

x <- c(1, NA, 3)
is.na(x)         # FALSE TRUE FALSE — test for missing values
x[!is.na(x)]    # remove NAs: keep only non-missing values

y <- NULL
is.null(y)       # TRUE
length(y)        # 0 — NULL has no length


# ── Tibbles — the tidyverse data frame ───────────────────────────────────────

# When you use the tidyverse, data frames become "tibbles" — a cleaner version
# that prints better and handles column types more predictably.
# They behave like data frames in almost all cases.

library(tidyverse)

trades_tbl <- tibble(
  symbol   = c("KXBTC15M", "KXETH15M", "KXBTC15M"),
  price    = c(0.72, 0.45, 0.88),
  win      = c(TRUE, FALSE, TRUE)
)

trades_tbl     # notice the cleaner print output vs data.frame


# ── Exercises ─────────────────────────────────────────────────────────────────

# 1. Create a data frame with 4 trades: symbol, price, quantity, win (T/F)
# 2. Access just the price column using $
# 3. Filter to only the winning trades using [] subsetting
# 4. Use table() on the win column — what does it tell you?
# 5. Use str() on your data frame and read the output
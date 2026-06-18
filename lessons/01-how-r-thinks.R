# Stage 1 — How R Thinks
# The mental model that makes everything else click.
# ─────────────────────────────────────────────────────────────────────────────


# ── Assignment ────────────────────────────────────────────────────────────────

# Use <- for assignment (idiomatic R). = also works but <- is convention.

x <- 42
name <- "Kris"
is_ready <- TRUE

x
name
is_ready


# ── Everything is a vector ────────────────────────────────────────────────────

# In R there is no such thing as a single value.
# Even x <- 42 creates a vector of length 1.
# This is the most important thing to understand about R.

length(x)        # 1 — it's a vector, just a short one
class(x)         # "numeric"

# c() combines values into a vector ("combine" or "concatenate")
scores <- c(98, 72, 45, 12, 88)
scores
length(scores)   # 5


# ── Vectorized operations ─────────────────────────────────────────────────────

# Operations apply to every element automatically — no loop needed.

scores * 2               # doubles every value
scores + 10              # adds 10 to every value
scores > 50              # returns TRUE/FALSE for each element
scores[scores > 50]      # keeps only values where condition is TRUE

# sum() on a logical vector counts the TRUEs
sum(scores > 50)         # how many scores are above 50?

# This is R's superpower. In Python you'd write a loop or list comprehension.
# In R, you just write the operation.


# ── Basic types ───────────────────────────────────────────────────────────────

a <- 3.14        # numeric (double)
b <- 3L          # integer (the L means "integer literal")
c_ <- "hello"    # character (string)
d <- TRUE        # logical (boolean) — TRUE/FALSE, not True/False like Python
e <- NA          # missing value — R's version of None, but it propagates

class(a)   # "numeric"
class(b)   # "integer"
class(c_)  # "character"
class(d)   # "logical"
class(e)   # "logical" — NA is typed

# NA propagates through calculations — this will surprise you
10 + NA        # NA
mean(c(1, 2, NA, 4))   # NA — because one value is unknown
mean(c(1, 2, NA, 4), na.rm = TRUE)   # 2.33 — explicitly ignore NAs


# ── Useful inspection functions ───────────────────────────────────────────────

prices <- c(0.98, 0.72, 0.45, 0.12, 0.88)

print(prices)    # explicit print (usually not needed — just type the name)
length(prices)   # number of elements
class(prices)    # type
str(prices)      # compact structure summary — very useful for complex objects


# ── Arithmetic operators ──────────────────────────────────────────────────────

10 + 3    # 13
10 - 3    # 7
10 * 3    # 30
10 / 3    # 3.333...
10 ^ 2    # 100  (exponent — R uses ^ not **)
10 %% 3   # 1    (modulo — remainder)
10 %/% 3  # 3    (integer division)


# ── Comparison operators ──────────────────────────────────────────────────────

5 > 3     # TRUE
5 < 3     # FALSE
5 == 5    # TRUE  (note: == not =)
5 != 3    # TRUE  (not equal)
5 >= 5    # TRUE
5 <= 4    # FALSE


# ── Indexing — 1-based ────────────────────────────────────────────────────────

# R counts from 1, not 0. This is different from Python.

scores <- c(98, 72, 45, 12, 88)
scores[1]        # 98  — first element (would be scores[0] in Python, but [0] returns nothing useful in R)
scores[5]        # 88  — last element
scores[2:4]      # 72 45 12 — elements 2 through 4 (inclusive on both ends)
scores[c(1, 3)]  # 98 45 — elements 1 and 3


# ── Exercises ─────────────────────────────────────────────────────────────────

# Try these in your console:

# 1. Create a vector of 5 trade P&L values (make some positive, some negative)
# 2. Find how many trades were profitable (P&L > 0) using sum()
# 3. Calculate the mean P&L using mean()
# 4. Extract only the profitable trades using [] subsetting

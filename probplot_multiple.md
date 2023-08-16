## `probplot_multiple` Function Documentation

### Description

The `probplot_multiple` function generates multiple probability plots (quantile-quantile plots) for a given set of datasets. It is based on the `probplot` function from the `e1071` package by David Meyer, with added tweaks for customization and additional features.

### Usage

```R
probplot_multiple(vectors, qdist = qnorm, probs = NULL, line = TRUE,
                  xlab = "Probability", ylab = NULL, stdev = FALSE,
                  xline = FALSE, yline = FALSE, stadj = 0, ...)
```

### Arguments

- `vectors`: A list of numeric vectors representing the datasets for which probability plots will be generated.
- `qdist`: A function specifying the theoretical distribution used for comparison. Default is `qnorm` (normal distribution).
- `probs`: Numeric vector of probabilities (quantiles) to be compared in the plot. If `NULL`, a default set of quantiles will be used.
- `line`: Logical value indicating whether to add red lines representing the linear regression lines to the plots. Default is `TRUE`.
- `xlab`: Label for the x-axis. Default is "Probability".
- `ylab`: Label for the y-axis. By default, the label will be based on the input data variable name.
- `stdev`: Logical value indicating whether to display vertical lines at -2σ, -σ, σ, and 2σ from the mean. Default is `FALSE`.
- `xline`: Numeric value indicating the quantile on the x-axis at which to draw a red dashed vertical line.
- `yline`: Numeric value indicating the y-coordinate at which to draw a red dashed horizontal line.
- `stadj`: A numeric value adjusting the vertical position of the standard deviation labels when `stdev` is enabled.
- `...`: Additional arguments that will be passed to the theoretical distribution function `qdist`.

### Value

An invisible list with the following components:

- `qdist`: A function representing the specified theoretical distribution.
- `int`: The intercepts of the linear regression lines (if `line` is `TRUE`).
- `slope`: The slopes of the linear regression lines (if `line` is `TRUE`).

### Details

The `probplot_multiple` function generates multiple probability plots by comparing the quantiles of each input dataset with the quantiles of the theoretical distribution specified by the `qdist` function. Each plot can include red linear regression lines, vertical lines for specified quantiles, and optional vertical lines at -2σ, -σ, σ, and 2σ from the mean. The `stadj` argument allows you to adjust the vertical position of the standard deviation labels when `stdev` is enabled.

### Examples

```R
# Generate multiple probability plots using the default parameters
set.seed(123)
x <- rnorm(100)
y <- rnorm(100, mean = 2, sd = 1.5)
z <- rnorm(100, mean = 3, sd = 1)
probplot_multiple(list(x, y, z))

# Generate multiple probability plots with custom labels and linear regression lines
probplot_multiple(list(x, y, z), xlab = "Custom X Label", ylab = "Custom Y Label", line = TRUE)

# Generate multiple probability plots with vertical lines at -σ, σ, and a custom quantile
probplot_multiple(list(x, y, z), stdev = TRUE, xline = 0.75, stadj = 0.7)
```

### Note

The `probplot_multiple` function returns an invisible list with information about the plots and the theoretical distribution. 

## `probplot_kc` Function Documentation

### Description

The `probplot_kc` function generates a probability plot (quantile-quantile plot) for a given dataset. It is based on the `probplot` function from the `e1071` package by David Meyer, with added tweaks for customization and additional features.

### Usage

```R
probplot_kc(x, qdist = qnorm, probs = NULL, line = TRUE,
            xlab = "Probability", ylab = NULL, stdev = FALSE,
            xline = FALSE, yline = FALSE, stadj = 0, ...)
```

### Arguments

- `x`: A numeric vector representing the dataset for which the probability plot will be generated.
- `qdist`: A function specifying the theoretical distribution used for comparison. Default is `qnorm` (normal distribution).
- `probs`: Numeric vector of probabilities (quantiles) to be compared in the plot. If `NULL`, a default set of quantiles will be used.
- `line`: Logical value indicating whether to add a red line representing the linear regression line to the plot. Default is `TRUE`.
- `xlab`: Label for the x-axis. Default is "Probability".
- `ylab`: Label for the y-axis. By default, the label will be based on the input data variable name.
- `stdev`: Logical value indicating whether to display vertical lines at -2σ, -σ, σ, and 2σ from the mean. Default is `FALSE`.
- `xline`: Numeric value indicating the quantile on the x-axis at which to draw a red dashed vertical line.
- `yline`: Numeric value indicating the y-coordinate at which to draw a red dashed horizontal line.
- `stadj`: A numeric value adjusting the vertical position of the standard deviation labels when `stdev` is `TRUE`. Default is `0`.
- `...`: Additional arguments that will be passed to the theoretical distribution function `qdist`.

### Value

An invisible list with the following components:

- `qdist`: A function representing the specified theoretical distribution.
- `int`: The intercept of the linear regression line (if `line` is `TRUE`).
- `slope`: The slope of the linear regression line (if `line` is `TRUE`).

### Details

The `probplot_kc` function generates a probability plot by comparing the quantiles of the input data `x` with the quantiles of the theoretical distribution specified by the `qdist` function. The plot can include a red linear regression line, vertical lines for specified quantiles, and optional vertical lines at -2σ, -σ, σ, and 2σ from the mean. The `stadj` argument allows you to adjust the vertical position of the standard deviation labels when `stdev` is enabled.

### Examples

```R
# Generate a probability plot using the default parameters
data <- rnorm(100)
probplot_kc(data)

# Generate a probability plot with a specified theoretical distribution (exponential)
probplot_kc(data, qdist = qexp)

# Generate a probability plot with custom quantiles and no linear regression line
probplot_kc(data, probs = c(0.1, 0.5, 0.9), line = FALSE)

# Generate a probability plot with vertical lines at the standard deviations and a custom quantile
probplot_kc(data, stdev = TRUE, xline = 0.75, stadj = 0.3)
```

### Note

The `probplot_kc` function returns an invisible list with information about the plot and the theoretical distribution. 

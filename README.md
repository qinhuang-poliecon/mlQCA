# mlQCA <img src="man/figures/mlQCA_logo.png" align="right" width="120"/>

### Machine Learning Enhanced Qualitative Comparative Analysis (QCA)

mlQCA is an R package designed to empower researchers with the capabilities of machine learning (ML) for conducting qualitative comparative analysis (QCA) more effectively. This package specifically addresses the limitations of QCA for large datasets by incorporating ML-enhanced condition selection and calibration.

At its core, mlQCA utilizes the extreme gradient boosting (XGBoost) tree ensemble algorithm for classification based on the outcome, assisting practitioners in finding explanatory conditions and calibration cut-offs that optimize the coverage of QCA solutions. Furthermore, the package provides the ability to iteratively evaluate QCA across a range of conditions, allowing for more in-depth analysis.

### Package Installation

The package is currently hosted on github and users can install directly from github:

``` r
devtools::install_github("qinhuang_poliecon/mlQCA")
```

### Test the package

Load sample data and test your installation:

``` r
library(mlQCA)
xgb <- buildXGboost(voteData, "vote")
fMetricModel <- getFeatureImp(xgb, voteData, "vote")
plot(xgb)
head(fMetricModel)
```

### Vignettes and examples

To build the vignettes for Celda and DecontX during installation from GitHub, use the following command:

``` r
library(devtools)
install_github("qinhuang_poliecon/mlQCA", build_vignettes = TRUE)
```

Note that installation may take an extra 5-10 minutes for building of the vignettes. The Celda and DecontX vignettes can then be accessed via the following commands:

``` r
vignette("celda")
```

Detailed documentation and workflow tutorial can be found at [mlQCA package site](https://qinhuang-poliecon.github.io/mlQCA/).

### Get help

Please address your questions and bug reports at: [mlQCA issues](https://github.com/qinhuang_poliecon/mlQCA/issues).

### Citation

mlQCA: a Machine-Learning Enhanced QCA R Package (in progress) **(2023)** <https://doi.org/XXXXXXXXXXXXXXXXXX>

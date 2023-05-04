## mlQCA <img src="man/figures/mlQCA_logo.png" align="right" width="150"/>
    
### Machine Learning Enhanced Qualitative Comparative Analysis (QCA)

mlQCA is an R package designed to empower researchers with the capabilities of machine learning (ML) for conducting qualitative comparative analysis (QCA) more effectively. This package specifically addresses the limitations of QCA for large datasets by incorporating ML-enhanced condition selection and calibration.

At its core, mlQCA utilizes the extreme gradient boosting (XGBoost) tree ensemble algorithm for classification based on the outcome, assisting practitioners in finding explanatory conditions and calibration cut-offs that optimize the coverage of QCA solutions. Furthermore, the package provides the ability to iteratively evaluate QCA across a range of conditions, allowing for more in-depth analysis.

### Package Installation (For Reviewers)

Please download the `mlQCA_Project_Folder.zip` file and unzip it. Then in the folder open the `mlQCA.Rproj` file. 

Next run:

```r
install.packages("devtools")
devtools::install()
```

Please follow instructions in the `vignettes/mlQCA.html` file to reproduce major results.


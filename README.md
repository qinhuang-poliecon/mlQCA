## mlQCA <img src="man/figures/mlQCA_logo.png" align="right" width="150"/>
    
### Machine Learning Enhanced Qualitative Comparative Analysis (mlQCA)

mlQCA is an R package designed to empower researchers with the capabilities of machine learning (ML) for conducting qualitative comparative analysis (QCA) more effectively. This package specifically addresses the limitations of QCA for large datasets by incorporating the empirical information suggested by ML to guide condition selection and calibration.

At its core, mlQCA utilizes the extreme gradient boosting (XGBoost) tree ensemble algorithm for classification based on the outcome, assisting practitioners in finding explanatory conditions and calibration cut-offs that optimize the coverage of QCA solutions. Furthermore, the package provides the ability to iteratively develop QCA models across a range of conditions, allowing for more inductive and explorative analysis.

### Package Installation 

Please download the `mlQCA_Project_Folder.zip` file and unzip it. Then, open the `mlQCA.Rproj` file in the folder. 

Next run:

```r
install.packages("devtools")
devtools::install()
```

To see how an mlQCA project can be executed, please follow the workflow provided in the `vignettes/mlQCA.html` file.


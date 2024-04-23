refer [[Bv_Analysis2]]

This is the R code for analysis od the data using limma. Code based on the GEO2r analysis.
# Pre_processing

```R
#Setting directory for work
setwd("D:/Bioinformatics_process/R_Data/Bv-p11")


# Version info: R 4.2.2, Biobase 2.58.0, GEOquery 2.66.0, limma 3.54.0
################################################################
# Loading libraries
library(GEOquery)
library(limma)
library(umap)

# Data accusation
# Download Data
gset <- getGEO("GSE13355", GSEMatrix =TRUE, AnnotGPL=TRUE)

#subset
if (length(gset) > 1) idx <- grep("GPL570", attr(gset, "names")) else idx <- 1
gset <- gset[[idx]]

```

This code is a conditional statement that ensures `gset` is properly indexed based on the condition, and then assigns the appropriate subset of `gset` back to `gset` for further processing.
The line `gset <- gset[[idx]]` suggests that you're trying to extract a specific element from the list `gset` using double brackets `[[ ]]`

```R
# make proper column names to match toptable 
#fvarLabels(gset) <- make.names(fvarLabels(gset))
fvarLabels(gset[[1]]) <- make.names(fvarLabels(gset[[1]]))
```

This line of code will modify the column names of the `ExpressionSet` object within your list (`gset`) to ensure they are properly formatted according to R's naming conventions.

```R
> class(gset)
[1] "list"
> str(gset)
```

## Grouping
```R
# group membership for all samples
gsms <- paste0("00000000000000000000000000000000000000000000000000",
               "00000000000000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
               "XXXXXXXXXXXXXXXXXXXXXX1111111111111111111111111111",
               "111111111111111111111111111111")
sml <- strsplit(gsms, split="")[[1]]
```

The `gsms` object seems to represent group memberships for samples, where each character represents a group.
(e.g., "0" for control group, "1" for Lesional skin biopsy group, "x" for Non-lesional skin biopsy group).
After executing this code, the variable `sml` will be a vector containing each individual character from the `gsms` string. This vector will be used to represent the 'design' of the data.
Selecting a subset of data-samples from the GEO data.

Data in the GEO "GSE13355"

| **Parameter**                            | **Value**            |
| ---------------------------------------- | -------------------- |
| Total samples                            | 180                  |
| Psoriatic patients                       | 58                   |
| Normal healthy controls                  | 64                   |
| Biopsies per patient                     | 2                    |
| Biopsy types per patient                 | Involved, Uninvolved |
| Biopsy size                              | 6mm punch            |
| Lesional skin biopsy source (PsA_lesion) | Psoriatic patients   |
| Non-lesional skin biopsy source          | Psoriatic patients   |
| Control biopsy source (Control)          | Healthy controls     |

Of the 180 samples only Lesional skin biopsy source (58) and Control biopsy source (64) samples were selected.

```R
# filter out excluded samples (marked as "X")
sel <- which(sml != "X")
sml <- sml[sel]
gset <- gset[ ,sel]
```

Samples reduced to 122 from 180.

---

# Differential expression

```R
# log2 transformation
ex <- exprs(gset)
qx <- as.numeric(quantile(ex, c(0., 0.25, 0.5, 0.75, 0.99, 1.0), na.rm=T))
LogC <- (qx[5] > 100) ||
  (qx[6]-qx[1] > 50 && qx[2] > 0)
if (LogC) { ex[which(ex <= 0)] <- NaN
exprs(gset) <- log2(ex) }
```


1. `ex <- exprs(gset)`: This extracts the expression values from the expression set object `gset` and stores them in the variable `ex`.

2. `qx <- as.numeric(quantile(ex, c(0., 0.25, 0.5, 0.75, 0.99, 1.0), na.rm=T))`: This computes the quantiles of the expression values `ex` at the specified probabilities (0, 0.25, 0.5, 0.75, 0.99, 1.0) and stores them in the vector `qx`. The `na.rm = TRUE` argument is used to handle any missing values in the expression data.

3. `LogC <- (qx[5] > 100) || (qx[6]-qx[1] > 50 && qx[2] > 0)`: This line checks if the data should be log2 transformed. It checks two conditions:
   - If the 99th percentile of the expression values (`qx[5]`) is greater than 100.
   - If the range between the maximum and minimum quantiles (`qx[6]-qx[1]`) is greater than 50 AND if the 25th percentile (`qx[2]`) is greater than 0.
   If either condition is true, `LogC` is set to `TRUE`, indicating that log2 transformation is necessary.

4. `if (LogC) { ex[which(ex <= 0)] <- NaN exprs(gset) <- log2(ex) }`: If `LogC` is `TRUE`, indicating that log2 transformation is needed, this block of code performs the following:
   - It sets the expression values that are less than or equal to 0 to `NaN` (Not a Number) to avoid taking the log of non-positive values.
   - It applies the log2 transformation to the expression values and assigns the transformed values back to the expression set object `gset` using `exprs(gset) <- log2(ex)`.

This code is designed to ensure that the data is appropriately transformed for downstream analysis, particularly when dealing with gene expression data where log transformation is a common preprocessing step.

## Adding meta data(control and PsA_lesion to the Data)

```R
# assign samples to groups and set up design matrix
gs <- factor(sml)
groups <- make.names(c("Control","PsA_lesion"))
levels(gs) <- groups
gset$group <- gs
design <- model.matrix(~group + 0, gset)
colnames(design) <- levels(gs)

```


```R
# Missing values remove
gset <- gset[complete.cases(exprs(gset)), ] # skip missing values
```
Setting up the design matrix for differential expression analysis using the `limma` package in R.


1. `gs <- factor(sml)`: This line converts the character vector `sml` into a factor, where each level of the factor represents a group to which samples belong. 

2. `groups <- make.names(c("Control","PsA_lesion"))`: This creates group names for the levels of the factor `gs`. It's using `make.names()` to ensure valid R variable names, derived from the character vector `c("Control", "PsA_lesion")`.

3. `levels(gs) <- groups`: This assigns the group names created in the previous step to the levels of the factor `gs`.

4. `gset$group <- gs`: This assigns the factor `gs` (which represents the groups) to a new column named `group` in the `gset` object.

5. `design <- model.matrix(~group + 0, gset)`: This creates a design matrix for the differential expression analysis. The formula `~group + 0` specifies that we want to model the groups as different conditions without an intercept. The `model.matrix` function converts the factor `group` into a design matrix suitable for linear modeling.

6. `colnames(design) <- levels(gs)`: This assigns the group names as column names to the design matrix, ensuring clarity in the subsequent analysis.

7. `gset <- gset[complete.cases(exprs(gset)), ]`: This line filters out rows in the `gset` object (presumably representing samples) that have any missing values in their expression data. It's a common preprocessing step to ensure that only complete cases are used in the analysis.

---

## Fitting Linear Model

```R
fit <- lmFit(gset, design)  # fit linear model
```
The `lmFit()` function from the `limma` package in R is used to fit a linear model to microarray data, typically for differential expression analysis. It takes the expression data (usually normalized) and the design matrix as input to model the expression levels based on the experimental design.

- `gset`: This contains the expression data. It's the matrix of gene expression values where rows represent genes and columns represent samples.

- `design`: This is the design matrix created in the previous step. It specifies how the samples are grouped into different experimental conditions or groups. Each column of the design matrix represents a different condition or group.

After fitting the linear model, the resulting object `fit` will contain the fitted model and can be used as input to functions like `eBayes()` to perform differential expression analysis and obtain statistical results.

```R
#### Setting Contrasts of Interest:
# set up contrasts of interest and recalculate model coefficients
cts <- paste(groups[1], groups[2], sep="-")
cont.matrix <- makeContrasts(contrasts=cts, levels=design)
fit2 <- contrasts.fit(fit, cont.matrix)
```

The code snippet you provided sets up contrasts of interest for your linear model and recalculates the model coefficients based on these contrasts. Here's a breakdown of what each line does:

After executing these steps, `fit2` will contain the fitted linear model with the coefficients adjusted according to the contrasts specified in `cont.matrix`. This adjusted model can be further analyzed to perform differential expression analysis and obtain statistical results specific to the contrasts of interest.


## Compute statistics and table of top significant genes

1. **Estimating Statistics:**
   ```R
   fit2 <- eBayes(fit2, 0.01)
   ```
   This line applies the empirical Bayes method to the linear model `fit2` to estimate the coefficients and calculate moderated t-statistics.

2. **Extracting Significant Genes:**
   ```R
   tT <- topTable(fit2, adjust="fdr", sort.by="B", number=250)
   ```
   This line generates a table (`tT`) containing the top significant genes based on the adjusted p-values (`adj.P.Val`) using the False Discovery Rate (FDR) correction. The results are sorted by the absolute value of the B-statistic (`B`) and limited to the top 250 genes.

3. **Selecting Relevant Columns:**
   ```R
   tT <- subset(tT, select=c("ID","adj.P.Val","P.Value","t","B","logFC","GenBank.Accession","Gene.symbol","Gene.title"))
   ```
   Here, the code selects specific columns from the `tT` table, including gene identifiers, adjusted p-values, raw p-values, t-statistics, B-statistics, log fold changes, GenBank Accession numbers, gene symbols, and gene titles.

4. **Writing Table to Output:**
   ```R
   write.table(tT, file=stdout(), row.names=F, sep="\t")
   ```
   Finally, this line writes the filtered and subsetted `tT` table to the standard output (`stdout()`) with tab-separated values (`sep="\t"`) and without row names.

This script effectively generates a tabular output of significant genes along with their relevant statistics and annotations, which can be further analyzed or exported for downstream processing.

---

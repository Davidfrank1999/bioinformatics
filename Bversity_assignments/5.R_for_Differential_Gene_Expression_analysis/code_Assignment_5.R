# Assignment 5
# Title:  R for Differential Gene Expression analysis
# For explinamtion look at the Assignment_5.md

install.packages("package_name")

library(package_name)

library(Biobase)
library(limma)
library(geneplotter)
library(enrichplot)
library(pheatmap)
library(ggplot2)
library(RColorBrewer)
library(ggrepel)
library(EnhancedVolcano)
library(clusterProfiler)

# For Affymetrix data
data <- ReadAffy()

# Replace paths with your actual file paths
exprsData <- read.delim("path/to/expression_data.txt")
phenoData <- read.delim("path/to/phenotype_data.txt")
featureData <- read.delim("path/to/feature_annotation.txt")


filtered_data <- exprs(data)[rowMeans(exprs(data)) > threshold, ]

# Filters the ExpressionSet (which includes the feature data and the expression data)
# to the genes that are not present in the Y chromosome
GSE27272_noY <-GSE27272_Eset[GSE27272_Eset@featureData@data$CHR!="Y",]

#------------------------------------------------------------------------
#--------------------------- Visualizing --------------------------------

# Creating an annotation dataframe for heatmap
annotation_for_heatmap <- data.frame(Phenotype = Biobase::pData(GSE27272_Eset)$sex)
row.names(annotation_for_heatmap) <- row.names(pData(GSE27272_Eset))

# Calculating sample-to-sample distances using Manhattan method
dists <- as.matrix(dist(t(GSE27272_exprs), method = "manhattan"))
rownames(dists) <- row.names(pData(GSE27272_Eset))

# Defining colors for the heatmap
hmcol <- rev(colorRampPalette(RColorBrewer::brewer.pal(9, "YlOrRd"))(255))

# Setting up distance matrix properties
colnames(dists) <- NULL
diag(dists) <- NA

# Defining annotation colors for sex
ann_colors <- list(
  Phenotype = c(female = "hotpink", male = "deepskyblue")
)

# Plotting the heatmap using pheatmap
pheatmap(dists, col = hmcol,
         annotation_row = annotation_for_heatmap,
         annotation_colors = ann_colors,
         legend = TRUE,
         treeheight_row = 0,
         legend_breaks = c(min(dists, na.rm = TRUE),
                           max(dists, na.rm = TRUE)),
         legend_labels = c("small distance", "large distance"),
         main = "Clustering heatmap for the GSE27272 samples")

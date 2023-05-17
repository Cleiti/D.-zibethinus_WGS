
library("DESeq2")
library(ggplot2)
library(pheatmap)

counts <- read.table("C:/Users/Cleiti/Desktop/sc10_count.txt", sep = "\t", header = TRUE)
counts_clean <- counts[, -1]
metadata <- read.table("C:/Users/Cleiti/Desktop/SraRunTable.txt", sep = ",", header = TRUE)
# Change counts column names exp ID
new_colnames <- c("SRR6156066", "SRR6156067", "SRR6156069", "SRR6040092", "SRR6040093", "SRR6040094", "SRR6040095", "SRR6040096", "SRR6040097")
colnames(counts_clean) <- new_colnames

setwd("C:/Users/Cleiti/Desktop/deseq")

#ANALYSING CULTIVAR DIFFERENCES:
# design value explanation: test for effect of cultivar controlling effect of tissue
dds <- DESeqDataSetFromMatrix(countData = counts_clean, colData = metadata, design = ~ Cultivar)
dds <- DESeq(dds)
res <- results(dds)
res

resOrdered <- res[order(res$padj),]
summary(res)

plotMA(res, ylim=c(-15,15))

ddsvst <- vst(dds)
pos_vec <- c(1, 1, -1, -1, 1)
plotPCA(ddsvst, intgroup="Cultivar") + labs(color = "Cultivar")

select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:10]
nt <- normTransform(dds)
log2.norm.counts <- assay(nt)[select,]
df <- as.data.frame(colData(dds)[c("Cultivar")])
labels <- c("E3 ubiquitin-protein ligase", "sialylation","V-type proton ATPase subunit", "gag-polypeptide of LTR copia-type", "UNKNOWN", "methionine", "glutamate synthase", "UNKNOWN", "UNKNOWN", "xyloglucan galactosyltransferase")
pheatmap(log2.norm.counts, cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df, labels_row=labels)



#ANALYSING TISSUE DIFFERENCES:

dds <- DESeqDataSetFromMatrix(countData = counts_clean, colData = metadata, design = ~ Tissue)
dds <- DESeq(dds)
res <- results(dds)
res

resOrdered <- res[order(res$padj),]
summary(res)

plotMA(res, ylim=c(-15,15))

ddsvst <- vst(dds)
pos_vec <- c(1, 1, -1, -1, 1)
plotPCA(ddsvst, intgroup="Tissue") + labs(color = "Tissue")

select <- order(rowMeans(counts(dds,normalized=TRUE)),decreasing=TRUE)[1:10]
nt <- normTransform(dds) # defaults to log2(x+1)
log2.norm.counts <- assay(nt)[select,]
df <- as.data.frame(colData(dds)[c("Tissue")])
labels <- c("E3 ubiquitin-protein ligase", "UNKNOWN", "V-type proton ATPase subunit", "UNKNOWN", "methionine", "UNKNOWN", "UNKNOWN", "glutamate synthase", "xyloglucan galactosyltransferase", "UNKNOWN")
pheatmap(log2.norm.counts, cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df, labels_row=labels)

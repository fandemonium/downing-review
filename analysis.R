#source("http://bioconductor.org/biocLite.R")
#biocLite("phyloseq")
#install.packages("plyr")
#install.packages("ggplot2")
#install.packages("data.table")
library(phyloseq)
library(plyr)
library(ggplot2)
library(data.table)
setwd("/Users/adina/scratch/downing-review")

==============
#LOAD FUNCTIONAL DATA
abund <- read.delim(sep='\t', file="./summary.tsv",header=TRUE, strip.white=TRUE, row.names=1)
abund <- read.delim(sep='\t', file="./summary_cum.tsv",header=TRUE, strip.white=TRUE, row.names=1)
abund$X <- NULL

meta <- read.delim(sep='\t', file="./meta.txt", header=TRUE, strip.white=TRUE, row.names=1)
meta$Notes<-NULL
meta$journal_name = rownames(meta)
#bmc.txt are not unique and causing issues when trying to set it as 
rownames(meta) = meta$Text.file.name

abundance_data_norm_matrix <- as.matrix(abund)
abundance <- otu_table(abundance_data_norm_matrix, taxa_are_rows=TRUE)
metadata <- sample_data(meta)

#phyloseq object with annotations
all <- phyloseq(metadata, abundance)
plot_bar(all, "OTU", fill="Sample")
#for this particular package, OTU=the keyword, Sample=Journal

mdf <- psmelt(all)
#summarizing average over experiment
#IF=Impact Factor
f <- ddply(mdf, .(OTU, Sample, IF, Who.added), summarise, SUM=sum(Abundance))
f$OTU <- factor(f$OTU, levels=f$OTU[order(-f$SUM)][1:20])
f <- subset(f, OTU != "<NA>")
p = ggplot(f, aes_string(x="OTU", y="SUM", fill="IF"))
p + geom_bar(stat="identity", colour="black")+theme_bw()+theme(strip.text.x=element_text(angle=90), axis.text.x=element_text(angle=90, size=5))+labs(y="# of observations (each bin represents a single journal)", x="keywords")
#just for fun, who added
p = ggplot(f, aes_string(x="OTU", y="SUM", fill="Who.added"))
p + geom_bar(stat="identity", colour="black")+theme_bw()+theme(strip.text.x=element_text(angle=90), axis.text.x=element_text(angle=90, size=5))+labs(y="# of observations")

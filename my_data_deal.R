library("Seurat")
library("ggplot2")
library("patchwork")
library("dplyr")
library("hdf5r")
#加载r包

route <- "D:/chenliangsheng/Spatial transcriptome/V3-1"
#设置路径

setwd(route)
#设置工作路径

data_dir <- route
#设置Load10X_Spatial的读取路径

file_name <- "raw_feature_bc_matrix.h5"
#设置表达矩阵名  

brain<- Load10X_Spatial(data.dir = data_dir, filename = file_name,slice = "anterior1")
#写入数据到brain中

plot1 <- VlnPlot(brain, features = "nCount_Spatial", pt.size = 0.3) + NoLegend()
plot2 <- SpatialFeaturePlot(brain, features = "nCount_Spatial",pt.size.factor = 2.5) + theme(legend.position = "right")
wrap_plots(plot1, plot2)
#做小提琴图和空间基因数据图

brain <- SCTransform(brain, assay = "Spatial", verbose = FALSE)
#保留空间位置信息的同时对数据进行归一化

top20<- head(VariableFeatures(brain),20)
#筛选出变化最大的10个基因

p5<- VariableFeaturePlot(brain,cols = c( "gray60", "red"))+NoLegend()
p6<- LabelPoints(plot = p5,points = top20, repel = TRUE,xnudge=0,ynudge=0)
p6
#展示高变基因

SpatialFeaturePlot(brain, features = top20[20],pt.size.factor = 2.4)
#展示10个变化最大的基因中的某个基因在HE染色图上的位置和数量


brain <- RunPCA(brain, assay = "SCT", verbose = FALSE)
brain <- FindNeighbors(brain, reduction = "pca", dims = 1:30)
brain <- FindClusters(brain, verbose = FALSE)
brain <- RunUMAP(brain, reduction = "pca", dims = 1:30)
#对原始数据进行降维

p7 <- DimPlot(brain, reduction = "umap", label = TRUE)
p8 <- SpatialDimPlot(brain, label = TRUE, label.size = 5,pt.size.factor = 2.6)
p7 + p8
#对降维图进行可视化

cortex <- subset(brain, idents = c(0,1,4,5,6,8,9,10,12,13))
# now remove additional cells, use SpatialDimPlots to visualize what to remove
# SpatialDimPlot(cortex,cells.highlight = WhichCells(cortex, expression = image_imagerow > 400 |
# image_imagecol < 150))
cortex <- subset(cortex, anterior1_imagerow > 400 | anterior1_imagecol < 150, invert = TRUE)
cortex <- subset(cortex, anterior1_imagerow > 275 & anterior1_imagecol > 370, invert = TRUE)
cortex <- subset(cortex, anterior1_imagerow > 250 & anterior1_imagecol > 440, invert = TRUE)
p1 <- SpatialDimPlot(cortex, crop = TRUE, label = TRUE,pt.size.factor = 2.5)
p2 <- SpatialDimPlot(cortex, crop = FALSE, label = TRUE, pt.size.factor = 3, label.size = 3)
p1

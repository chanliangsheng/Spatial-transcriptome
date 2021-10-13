library("Seurat")
library("ggplot2")
library("patchwork")
library("dplyr")
library("hdf5r")
#加载r

route1 <- "D:/研究生学习/mission/空间代谢组学数据/A/A6(T liver)"
#设置路径
setwd(route1)
#设置工作路径
data_dir <- route1
#设置Load10X_Spatial的读取路
file_name <- "raw_feature_bc_matrix.h5"
#设置表达矩阵  
A6 <- Load10X_Spatial(data.dir = data_dir, filename = file_name,slice = "anterior1")
#写入数据到A6
A6 <- SCTransform(A6, assay = "Spatial", verbose = FALSE)
#保留空间位置信息的同时对数据进行归一化
A6 <- FindSpatiallyVariableFeatures(A6, assay = "SCT", features = VariableFeatures(A6)[1:1000], selection.method = "markvariogram")
#计算空间中分布不同的基因
A6_top.features <- head(SpatiallyVariableFeatures(A6, selection.method ="markvariogram"), 500)
#挑选空间中最不同的基因的前x个


route2 <- "D:/研究生学习/mission/空间代谢组学数据/A/A4(TPT)"
#设置路径
setwd(route2)
#设置工作路径
data_dir <- route2
#设置Load10X_Spatial的读取路
file_name <- "raw_feature_bc_matrix.h5"
#设置表达矩阵  
A4 <- Load10X_Spatial(data.dir = data_dir, filename = file_name,slice = "anterior1")
#写入数据到A4
A4 <- SCTransform(A4, assay = "Spatial", verbose = FALSE)
#保留空间位置信息的同时对数据进行归一化
A4 <- FindSpatiallyVariableFeatures(A4, assay = "SCT", features = VariableFeatures(A4)[1:1000], selection.method = "markvariogram")
#计算空间中分布不同的基因
A4_top.features <- head(SpatiallyVariableFeatures(A4, selection.method ="markvariogram"), 500)
#挑选空间中最不同的基因的前x个



# setwd("D:/研究生学习/mission/空间代谢组学数据/A/4 group merge")
# 
# mass_end <- read.table(file = "4_group_merge.txt",header = FALSE)
# mass_end <- as.matrix(mass_end)
# mass_end <- as.vector(mass_end)
# for (i in 1:length(mass_end)) {
#   png_name <- paste0(mass_end[i],"_4_group_merge(A).png")
#   #将文件名改变
#   png(file=png_name,height = 1200 , width = 1200 ,res = 150)
#   #生成空白png文件
#   print(SpatialFeaturePlot(A6, features = mass_end[i],pt.size.factor = 2.8) + SpatialFeaturePlot(A4, features = mass_end[i],pt.size.factor = 2.5))
#   #展示10个变化最大的基因中的某个基因在HE染色图上的位置和数量，print将其粘贴在空白png文件中
#   warn <- paste0("The ",i," is done")
#   #提醒的代码
#   print(warn)
#   #打印提醒的代码
#   dev.off()
#   #关闭png输出文件窗口，每次循环都要关闭
# }

merge_result <- intersect(A6_top.features,A4_top.features)
#求交集，求相同的基因

setwd("D:/研究生学习/mission/空间代谢组学数据/A/merge")
#设置输出图片的路径

for (i in 1:length(merge_result)) {
  png_name <- paste0(merge_result[i],".png")
  #将文件名改变
  png(file=png_name,width = 1600 ,height = 1200 , res = 150)
  #生成空白png文件
  print(SpatialFeaturePlot(A6, features = merge_result[i],pt.size.factor = 2.8) + SpatialFeaturePlot(A4, features = merge_result[i],pt.size.factor = 2.5))
  #展示10个变化最大的基因中的某个基因在HE染色图上的位置和数量，print将其粘贴在空白png文件中
  warn <- paste0("The ",i," is done")
  #提醒的代码
  print(warn)
  #打印提醒的代码
  dev.off()
  #关闭png输出文件窗口，每次循环都要关闭
}
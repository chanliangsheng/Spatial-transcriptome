setwd("D:/研究生学习/mission/空间代谢组学数据/A/A组中比较好的")
A_good <- dir()

setwd("D:/研究生学习/mission/空间代谢组学数据/V/V组中比较好的")
V_good <- dir()

setwd("D:/研究生学习/mission/空间代谢组学数据/X/X组中比较好的")
X_good <- dir()

setwd("D:/研究生学习/mission/空间代谢组学数据/Y/Y组中比较好的")
Y_good <- dir()

merge_result <- c(A_good,V_good,X_good)
merge_result <- unique(merge_result)

delete_number <- match(Y_good,merge_result)
delete_number <- na.omit(delete_number)

merge_result <- merge_result[-delete_number]

for (i in 1:length(merge_result)) {
  merge_result[i] <- substring(merge_result[i],first = 1,last = (nchar(merge_result[i])-4))
}


setwd("D:/研究生学习/mission/空间代谢组学数据/Y/其他组的高变基因在Y的HE染色图上的情况")

for (i in 1:length(merge_result)) {
  png_name <- paste0(merge_result[i],".png")
  #将文件名改变
  png(file=png_name,width = 1600 ,height = 1200 , res = 150)
  #生成空白png文件
  print(SpatialFeaturePlot(Y3_2, features = merge_result[i],pt.size.factor = 2) + SpatialFeaturePlot(Y2_3, features = merge_result[i],pt.size.factor = 2.5))
  #展示10个变化最大的基因中的某个基因在HE染色图上的位置和数量，print将其粘贴在空白png文件中
  warn <- paste0("The ",i," is done")
  #提醒的代码
  print(warn)
  #打印提醒的代码
  dev.off()
  #关闭png输出文件窗口，每次循环都要关闭
}

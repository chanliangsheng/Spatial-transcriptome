library("png")


get_whole_file <- function(location){
  setwd(location)
  return(dir())
}
A_merge_file <- get_whole_file(location = "D:/研究生学习/mission/空间代谢组学数据/A/4 group merge")
V_merge_file <- get_whole_file(location = "D:/研究生学习/mission/空间代谢组学数据/V/4 group merge")
X_merge_file <- get_whole_file(location = "D:/研究生学习/mission/空间代谢组学数据/X/4 group merge")
Y_merge_file <- get_whole_file(location = "D:/研究生学习/mission/空间代谢组学数据/Y/4 group merge")

for (i in 1:length(A_merge_file)) {
  setwd("D:/研究生学习/mission/空间代谢组学数据/A/4 group merge")
  A_image <- readPNG(source = A_merge_file[i] , native = TRUE ,info = TRUE)
  setwd("D:/研究生学习/mission/空间代谢组学数据/V/4 group merge")
  V_image <- readPNG(source = V_merge_file[i] , native = TRUE ,info = TRUE)
  setwd("D:/研究生学习/mission/空间代谢组学数据/X/4 group merge")
  X_image <- readPNG(source = X_merge_file[i] , native = TRUE ,info = TRUE)
  setwd("D:/研究生学习/mission/空间代谢组学数据/Y/4 group merge")
  Y_image <- readPNG(source = Y_merge_file[i] , native = TRUE ,info = TRUE)
  
  png_name <- A_merge_file[i]
  #将文件名改变
  
  setwd("D:/研究生学习/mission/空间代谢组学数据/4 group merge")
  
  png(file=png_name,height = 1100 , width = 1900 ,res = 300)
  #生成空白png文件
  split.screen(c(2,2))
  #分成四个屏幕
  screen(1)
  print(rasterImage(A_image , xleft = 0.1, xright = 1, ybottom = -0.4, ytop = 1.3, interpolate = TRUE))
  screen(2)
  print(rasterImage(V_image , xleft = 0.1, xright = 1, ybottom = -0.4, ytop = 1.3, interpolate = TRUE))
  screen(3)
  print(rasterImage(X_image , xleft = 0.1, xright = 1, ybottom = -0.4, ytop = 1.3, interpolate = TRUE))
  screen(4)
  print(rasterImage(Y_image , xleft = 0.1, xright = 1, ybottom = -0.4, ytop = 1.3, interpolate = TRUE))
  dev.off()
  #关闭png输出文件窗口，每次循环都要关闭
  print(i)
  
}
library("png")

merge_2_same_photo <- function(location_1,location_2,output_location){
  setwd(location_1)
  dir_1 <- dir()
  
  setwd(location_2)
  dir_2 <- dir()
  
  merge_result <- intersect(dir_1,dir_2)
  #求两个病人基因的交集
  
  for (i in 1:length(merge_result)) {
    setwd(location_1)
    image_1 <- readPNG(source = merge_result[i] , native = TRUE ,info = TRUE)
    
    setwd(location_2)
    image_2 <- readPNG(source = merge_result[i] , native = TRUE ,info = TRUE)
    
    setwd(output_location)
    #设置输出图片的路径
    png_name <- merge_result[i]
    png(file=png_name,height = 1200 , width = 1600 ,res = 150)
    #生成空白png文件
    split.screen(c(1,2))
    #分成两个屏幕
    screen(1)
    print(rasterImage(image_1 , xleft = 0, xright = 1, ybottom = 0.2, ytop = 0.75, interpolate = TRUE))
    
    screen(2)
    print(rasterImage(image_2 , xleft = 0, xright = 1, ybottom = 0.2, ytop = 0.75, interpolate = TRUE))
    
    dev.off()
    #关闭png输出文件窗口，每次循环都要关闭
  }
}

location_1 <- "D:/研究生学习/mission/空间代谢组学数据/A/merge"
location_2 <- "D:/研究生学习/mission/空间代谢组学数据/V/merge"
output_location <- "D:/研究生学习/mission/空间代谢组学数据/V_A的交集"

merge_2_same_photo(location_1 = "D:/研究生学习/mission/空间代谢组学数据/A/merge",
                   location_2 = "D:/研究生学习/mission/空间代谢组学数据/X/merge",
                   output_location = "D:/研究生学习/mission/空间代谢组学数据/A_X的交集")



merge_2_same_photo(location_1 = "D:/研究生学习/mission/空间代谢组学数据/A/merge",
                   location_2 = "D:/研究生学习/mission/空间代谢组学数据/Y/merge",
                   output_location = "D:/研究生学习/mission/空间代谢组学数据/A_Y的交集")


merge_2_same_photo(location_1 = "D:/研究生学习/mission/空间代谢组学数据/V/merge",
                   location_2 = "D:/研究生学习/mission/空间代谢组学数据/Y/merge",
                   output_location = "D:/研究生学习/mission/空间代谢组学数据/V_Y的交集")


merge_2_same_photo(location_1 = "D:/研究生学习/mission/空间代谢组学数据/X/merge",
                   location_2 = "D:/研究生学习/mission/空间代谢组学数据/Y/merge",
                   output_location = "D:/研究生学习/mission/空间代谢组学数据/X_Y的交集")
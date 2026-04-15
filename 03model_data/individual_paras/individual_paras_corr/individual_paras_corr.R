#--------------实际采用
df <- read.csv("DATA.csv", header = TRUE)
library(GGally)
library(ggplot2)

# 自定义只显示相关系数（无星号）的函数（保留但不再使用，仅兼容代码结构）
cor_no_stars <- function(data, mapping, ...) {
  x <- eval_data_col(data, mapping$x)
  y <- eval_data_col(data, mapping$y)
  corr <- cor(x, y, use = "pairwise.complete.obs")
  
  ggplot(data = data, mapping = mapping) +
    geom_text(
      aes(x = 0.5, y = 0.5, label = sprintf("Corr:\n%.3f", corr)),
      size = 3,  
      color = "#9E9E9E",
      hjust = 0.5,  
      vjust = 0.5   
    ) +
    theme_void()  
}

# 自定义下三角函数：散点图 + 顶部标注相关系数
scatter_with_corr_label <- function(data, mapping, ...) {
  # 提取x和y变量并计算相关系数
  x <- eval_data_col(data, mapping$x)
  y <- eval_data_col(data, mapping$y)
  corr <- cor(x, y, use = "pairwise.complete.obs")
  
  # 绘制散点图 + 顶部标注r=相关系数
  ggplot(data = data, mapping = mapping) +
    geom_point(size = 1.2, color = "#3366cc", alpha = 0.7) + # 散点样式
    # 添加相关系数标注（固定在图表顶部）
    annotate(
      "text", 
      x = mean(range(x, na.rm = TRUE)),  # x轴居中
      y = max(range(y, na.rm = TRUE)) * 1.15,  # y轴顶部（1.05是偏移系数）
      label = sprintf("r=%.3f", corr),  # 标注文本：r=相关系数
      size = 3,  # 字体大小
      color = "black",
      fontface = "bold"  # 加粗
    ) +
    theme_bw()  # 匹配整体主题
}

# 绘制仅下三角的散点图矩阵（带顶部相关系数标注）
ggpairs(df,
        upper = list(continuous = "blank"),  # 隐藏上三角
        lower = list(continuous = scatter_with_corr_label), # 自定义下三角（散点+标注）
        diag = list(continuous = "blank")) +  # 隐藏对角线
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text = element_text(size = 8),           
    axis.title = element_text(size = 10)          
  )

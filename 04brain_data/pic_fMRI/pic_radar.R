library(fmsb)

df <- read.csv("dACCradar.csv", stringsAsFactors = FALSE)
data <- as.data.frame(t(df$corr))
colnames(data) <- df$word

# 添加最大值和最小值行
data <- rbind(
  rep(0.4, ncol(data)),  # 最大值
  rep(0, ncol(data)),     # 最小值
  data
)

# 设置半透明颜色
fill_col <- adjustcolor("#456990", alpha.f = 0.3)  # 透明度 30%

# 保存为 300dpi PNG
png("Fig3.I_dACC.png", width = 16, height = 15, units = "in", res = 300)
par(family = "Arial")  # 字体


radarchart(
  data,
  axistype = 1,
  pcol = "#456990",     # 线条颜色
  pfcol = fill_col,     # 填充颜色
  plwd = 2,
  cglcol = "grey",
  cglty = 3,
  axislabcol = "grey",
  vlcex = 3,
  caxislabels = rep("", 5)        # 隐藏刻度标签
  #caxislabels = c(0, 0.1, 0.2, 0.3, 0.4),     # 隐藏刻度标签
)

dev.off()
--------------------
library(fmsb)

df <- read.csv("mPFCradar.csv", stringsAsFactors = FALSE)
data <- as.data.frame(t(df$corr))
colnames(data) <- df$word

# 添加最大值和最小值行
data <- rbind(
  rep(0.24, ncol(data)),  # 最大值
  rep(0, ncol(data)),     # 最小值
  data
)

# 设置半透明颜色
fill_col <- adjustcolor("#48C0AA", alpha.f = 0.3)  # 透明度 30%

# 保存为 300dpi PNG
png("Fig3.F_mPFC.png", width = 16, height = 15, units = "in", res = 300)
par(family = "Arial")  # 字体


radarchart(
  data,
  axistype = 1,
  pcol = "#48C0AA",     # 线条颜色
  pfcol = fill_col,     # 填充颜色
  plwd = 2,
  cglcol = "grey",
  cglty = 3,
  axislabcol = "grey",
  vlcex = 3,
  caxislabels = rep("", 5)        # 隐藏刻度标签
  #caxislabels = c(0, 0.06, 0.12,0.18, 0.24),     # 隐藏刻度标签
)

dev.off()

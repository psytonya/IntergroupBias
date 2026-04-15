# 加载包
library(ggplot2)
library(dplyr)

# ====================== 数据路径 ======================
df <- read.csv("RT_distribution.csv")
# ======================================================

# 计算均值（用于标注）
mean_rt <- mean(df$RT, na.rm = TRUE)

# 🌟 美化版绘图
ggplot(df, aes(x = RT)) +
  
  # 直方图（更美观）
  geom_histogram(
    aes(y = after_stat(density)),
    binwidth = 0.1,
    fill = "#456990",
    color = "white",
    alpha = 0.6
  ) +
  
  # 密度曲线
  geom_density(
    color = "#1D3557",
    linewidth = 1.3
  ) +
  
  # 均值竖线
  geom_vline(
    xintercept = mean_rt,
    color = "#1D3557",
    linetype = "dashed",
    linewidth = 1.0
  ) +
  
  # 横轴 0-6 秒
  scale_x_continuous(
    limits = c(0, 6),
    breaks = seq(0, 6, 0.5)
  ) +
  
  # 标签
  labs(
    x = "Reaction Time (seconds)",
    y = "Density"
    
  ) +
  
  # 🌟 学术高颜值主题
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 24, face = "bold"),
    axis.title = element_text(size = 24),
    axis.text = element_text(size = 24),
    panel.grid = element_line(alpha = 0.3)
  )

# 🌟 自动保存高清图片（会保存在你的工作目录里）
ggsave(
  "RT_Distribution.png",
  dpi = 300,          # 高清300dpi
  width = 12,
  height = 6,
  units = "in"
)

# 计算RT的描述统计
rt_min  <- min(df$RT, na.rm = TRUE)
rt_max  <- max(df$RT, na.rm = TRUE)
rt_mean <- mean(df$RT, na.rm = TRUE)
rt_sd   <- sd(df$RT, na.rm = TRUE)

# 输出结果
cat("RT范围: ", rt_min, "-", rt_max, "\n")
cat("RT均值: ", rt_mean, "\n")
cat("RT标准差: ", rt_sd, "\n")
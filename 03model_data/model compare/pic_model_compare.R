#install.packages("ggplot2")    # 安装 ggplot2 包
#install.packages("gridExtra")  # 安装 gridExtra 包
#install.packages("grid")      # 安装 grid 包

library(ggplot2)
library(gridExtra)

#####looic#####

# 确保数据列是数值型
data <- data.frame(
  Model = factor(c("M1", "M2", "M3", "M4"), 
                 levels = c("M1", "M2", "M3", "M4")),
  Value = as.numeric(c(9883.974,
                       7979.841,
                       7961.686,
                       8526.206
                       
  )),
  Weight = as.numeric(c(0, 0, 1, 0))  # 权重数据
)

# 检查数据
print(data)

# 找到最小值的数值
min_value <- min(data$Value)

  # 绘制条形图
  red_gradient_plot <- ggplot(data, aes(x = Model, y = Value, fill = Value)) +
  geom_bar(stat = "identity", color = "black", width = 0.6) +
  
  # 添加渐变线条
  geom_segment(aes(x = Model, xend = Model, y = 7000, yend = Weight * 3000 + 7000, color = Weight), 
                 linetype = "solid", size = 1.2) +
  # 添加渐变点
  geom_point(aes(x = Model, y = Weight * 3000 + 7000, color = Weight), size = 3.5) +
  # 设置渐变颜色
  scale_color_gradient(low = "#ffc2d1", high = "#ff006e", name = "Weight",limits = c(0, 1), breaks = seq(0, 1, 0.25)) + 
    
  #绘制数值标签（最后绘制，避免被覆盖）  
  #geom_text(aes(label = round(Value, 2)), hjust = -0.05, color = "black", size = 4.5,face = "bold", family = "Arial") +  # 使用hjust控制文本向右偏移
  geom_text(aes(label = round(Value, 3)), hjust = -0.05, color = "#495057", size = 5, fontface = "bold", family = "Arial")+  # Use fontface for bold text
    scale_fill_gradient(
    low = "#9d4ebb", 
    high = "#72ddf7", 
    limits = c(7000, 10000),  # 设置渐变标签范围
    breaks = seq(7000, 10000, 500),
    name = "Score"
  ) +
  scale_y_continuous(
    limits = c(7000, 10000),
    breaks = seq(7000, 10000, 500),
    oob = scales::squish,  # 超出范围的值映射到边界
    expand = c(0, 50),  # 使 y 轴从 8000 开始，去掉默认的扩展空间
    sec.axis = sec_axis(
      trans = ~ (.-7000) / 3000,  # 将 Value 轴映射到 Weight 轴，8000 对应 0，11500 对应 1
      name = "Weight",
      breaks = seq(0, 1, 0.1)  # Weight 轴刻度间隔为 0.1
    )
  ) +
  theme_minimal(base_size = 14, base_family = "Arial") +  # 设置字体为新罗马
  theme(
    #axis.title.y = element_text(size = 20,color = "black"),
    #axis.title.x = element_text(size = 20,color = "black"),
    # 调整 Weight 标题（次级轴在顶部）的距离
    # margin(b = 20) 表示增加底部的外边距，将标题推离轴线
    axis.title.x.top = element_text(size = 20, color = "black", margin = margin(b = 10)),
    
    # 同时建议微调底部的 LOOIC 标题，避免太挤
    # margin(t = 15) 表示增加顶部的外边距，将标题向下推离轴线
    axis.title.x = element_text(size = 20, color = "black", margin = margin(t = 10)),
    
    # 调整左侧 Model 标题的距离
    axis.title.y = element_text(size = 20, color = "black", margin = margin(r = 10)),
    axis.text.y = element_text(size = 18, hjust = 1,color = "black"),
    axis.text.x = element_text(size = 18, color = "black",angle = 0, hjust = 0.5),
    panel.grid.major = element_blank(),  # 删除主网格线
    panel.grid.minor = element_blank(),  # 删除次网格线
    axis.line.x = element_line(color = "black", size = 0.8),  # 保留横轴的线
    axis.line.y = element_line(color = "black", size = 0.8),  # 保留纵轴的线
    axis.ticks = element_line(color = "black"),  # 显示坐标轴刻度
    legend.position = "right",  # 图例放置右侧
    #设置图例标题和文本
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 12)
  ) +
  labs(x = "Model", y = "LOOIC", title = "Model comparison") +
  theme(plot.title = element_text(size = 18, hjust = 0.5))+
  #theme(plot.title = element_text(hjust = 0.5)) +  # 将标题居中
  coord_flip(ylim = c(7000, 10000), clip = "off") +  # 翻转坐标轴，Value 起点从 8000 开始
  geom_hline(
    aes(yintercept = min_value),  # 设置水平线的 y 值对应最小的 Value
    color = "#e9ff70",  # 设置线的颜色为黄色
    linetype = "dashed",  # 设置虚线
    size = 0.8  # 设置线宽
  ) 
  

# 显示图形
print(red_gradient_plot)

# 保存为 PNG 文件
png("model_comparison_looic.png", width = 14, height = 6, units = "in", res = 300)
print(red_gradient_plot)
dev.off()



#####waic#####

# 确保数据列是数值型
data <- data.frame(
  Model = factor(c("M1", "M2", "M3", "M4"), 
                 levels = c("M1", "M2", "M3", "M4")),
  Value = as.numeric(c(9755.754,
                       7831.087,
                       7809.392,
                       8381.797
                       
  )),
  Weight = as.numeric(c(0, 0, 1, 0))  # 假设这是权重数据
)

# 检查数据
print(data)

# 找到最小值的数值
min_value <- min(data$Value)

# 绘制条形图
red_gradient_plot <- ggplot(data, aes(x = Model, y = Value, fill = Value)) +
  geom_bar(stat = "identity", color = "black", width = 0.6) +
  
  # 添加渐变线条
  geom_segment(aes(x = Model, xend = Model, y = 7000, yend = Weight * 3000 + 7000, color = Weight), 
               linetype = "solid", size = 1.2) +
  # 添加渐变点
  geom_point(aes(x = Model, y = Weight * 3000 + 7000, color = Weight), size = 3.5) +
  # 设置渐变颜色
  scale_color_gradient(low = "#ffc2d1", high = "#ff006e", name = "Weight",limits = c(0, 1), breaks = seq(0, 1, 0.25)) + 
  
  #绘制数值标签（最后绘制，避免被覆盖）  
  #geom_text(aes(label = round(Value, 2)), hjust = -0.05, color = "black", size = 4.5,face = "bold", family = "Arial") +  # 使用hjust控制文本向右偏移
  geom_text(aes(label = round(Value, 3)), hjust = -0.05, color = "#495057", size = 5, fontface = "bold", family = "Arial")+  # Use fontface for bold text
  scale_fill_gradient(
    low = "#9d4ebb", 
    high = "#72ddf7", 
    limits = c(7000, 10000),  # 设置渐变标签范围
    breaks = seq(7000, 10000, 500),
    name = "Score"
  ) +
  scale_y_continuous(
    limits = c(7000, 10000),
    breaks = seq(7000, 10000, 500),
    oob = scales::squish,  # 超出范围的值映射到边界
    expand = c(0, 50),  # 使 y 轴从 8000 开始，去掉默认的扩展空间
    sec.axis = sec_axis(
      trans = ~ (.-7000) / 3000,  # 将 Value 轴映射到 Weight 轴，8000 对应 0，11500 对应 1
      name = "Weight",
      breaks = seq(0, 1, 0.1)  # Weight 轴刻度间隔为 0.1
    )
  ) +
  theme_minimal(base_size = 14, base_family = "Arial") +  # 设置字体为新罗马
  theme(
    #axis.title.y = element_text(size = 20,color = "black"),
    #axis.title.x = element_text(size = 20,color = "black"),
    # 调整 Weight 标题（次级轴在顶部）的距离
    # margin(b = 20) 表示增加底部的外边距，将标题推离轴线
    axis.title.x.top = element_text(size = 20, color = "black", margin = margin(b = 10)),
    
    # 同时建议微调底部的 LOOIC 标题，避免太挤
    # margin(t = 15) 表示增加顶部的外边距，将标题向下推离轴线
    axis.title.x = element_text(size = 20, color = "black", margin = margin(t = 10)),
    
    # 调整左侧 Model 标题的距离
    axis.title.y = element_text(size = 20, color = "black", margin = margin(r = 10)),
    axis.text.y = element_text(size = 18, hjust = 1,color = "black"),
    axis.text.x = element_text(size = 18, color = "black",angle = 0, hjust = 0.5),
    panel.grid.major = element_blank(),  # 删除主网格线
    panel.grid.minor = element_blank(),  # 删除次网格线
    axis.line.x = element_line(color = "black", size = 0.8),  # 保留横轴的线
    axis.line.y = element_line(color = "black", size = 0.8),  # 保留纵轴的线
    axis.ticks = element_line(color = "black"),  # 显示坐标轴刻度
    legend.position = "right",  # 图例放置右侧
    #设置图例标题和文本
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 12)
  ) +
  labs(x = "Model", y = "WAIC", title = "Model comparison") +
  theme(plot.title = element_text(size = 18, hjust = 0.5))+
  #theme(plot.title = element_text(hjust = 0.5)) +  # 将标题居中
  coord_flip(ylim = c(7000, 10000), clip = "off") +  # 翻转坐标轴，Value 起点从 8000 开始
  geom_hline(
    aes(yintercept = min_value),  # 设置水平线的 y 值对应最小的 Value
    color = "#e9ff70",  # 设置线的颜色为黄色
    linetype = "dashed",  # 设置虚线
    size = 0.8  # 设置线宽
  ) 


# 显示图形
print(red_gradient_plot)

# 保存为 PNG 文件
png("model_comparison_waic.png", width = 14, height = 6, units = "in", res = 300)
print(red_gradient_plot)
dev.off()



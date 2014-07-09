library(datasets)
rock2 <- rock
names(rock2) <- c("面积", "周长", "形状", "渗透性")

# Cairo包的PNG设备似乎无法显示中文字符，强制使用R自身的png()设备
options(shiny.usecairo = FALSE)

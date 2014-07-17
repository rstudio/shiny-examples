library(datasets)
rock2 <- rock
names(rock2) <- c("面积", "周长", "形状", "渗透性")

# Cairo包的PNG设备似乎无法显示中文字符，强制使用R自身的png()设备
options(shiny.usecairo = FALSE)

# 请忽略以下代码，它只是为了解决ShinyApps上没有中文字体的问题
if (system('locate wqy-zenhei.ttc') != 0 &&
      !file.exists('~/.fonts/wqy-zenhei.ttc') &&
      file.exists('wqy-zenhei.ttc')) {
  dir.create('~/.fonts')
  file.copy('wqy-zenhei.ttc', '~/.fonts')
  system2('fc-cache', '-f ~/.fonts')
}

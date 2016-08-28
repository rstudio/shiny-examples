# 定义用户界面
fluidPage(

  # 标题
  titlePanel("麻麻再也不用担心我的Shiny应用不能显示中文了"),

  # 侧边栏布局
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "请选一个数据：",
                  choices = c("岩石", "pressure", "cars")),

      uiOutput("rockvars"),

      numericInput("obs", "查看多少行数据？", 5),

      checkboxInput("summary", "显示概要", TRUE)
    ),

    # 展示一个HTML表格
    mainPanel(
      conditionalPanel("input.dataset === '岩石'", plotOutput("rockplot")),

      verbatimTextOutput("summary这里也可以用中文"),

      tableOutput("view")
    )
  )
)

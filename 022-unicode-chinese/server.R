library(datasets)

# 定义服务器逻辑
function(input, output) {

  cars2 <- cars
  cars2$random <- sample(
    strsplit("随意放一些中文字符", "")[[1]], nrow(cars2), replace = TRUE
  )

  # 返回数据集，注意input$dataset返回的结果可能是中文“岩石”
  datasetInput <- reactive({
    if (input$dataset == "岩石") return(rock2)
    if (input$dataset == "pressure") return(pressure)
    if (input$dataset == "cars") return(cars2)
  })

  output$rockvars <- renderUI({
    if (input$dataset != "岩石") return()
    selectInput("vars", "从岩石数据中选择一列作为自变量", names(rock2)[-1])
  })

  output$rockplot <- renderPlot({
    validate(need(input$vars, ""))
    par(mar = c(4, 4, .1, .1))
    plot(as.formula(paste("面积 ~ ", input$vars)), data = rock2)
  })

  # 数据概要信息
  output[['summary这里也可以用中文']] <- renderPrint({
    if (!input$summary) return(cat("数据概要信息被隐藏了！"))
    dataset <- datasetInput()
    summary(dataset)
  })

  # 显示前"n"行数据
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
}

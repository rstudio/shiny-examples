library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)
library(randomForest)
library(rpart)

# ── Available datasets ────────────────────────────────────────────────────────
DATASETS <- c(
  "Iris (Classification)"        = "iris",
  "mtcars (Regression)"          = "mtcars",
  "Swiss Fertility (Regression)" = "swiss",
  "Air Quality (Regression)"     = "airquality"
)

load_dataset <- function(name) {
  switch(name,
    iris       = iris,
    mtcars     = mtcars,
    swiss      = swiss,
    airquality = na.omit(airquality)
  )
}

is_classification <- function(v) {
  is.factor(v) || is.character(v) || length(unique(v)) <= 10
}

palette_main  <- "#2c3e50"
palette_blue  <- "#2980b9"
palette_red   <- "#e74c3c"
palette_green <- "#27ae60"

# ── UI ────────────────────────────────────────────────────────────────────────
header <- dashboardHeader(
  title = "ML Explorer"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebar_menu",
    menuItem("Data Explorer",  tabName = "data",  icon = icon("table")),
    menuItem("Model Training", tabName = "train", icon = icon("cogs")),
    menuItem("Performance",    tabName = "perf",  icon = icon("bar-chart")),
    menuItem("Visualizations", tabName = "viz",   icon = icon("eye"))
  ),

  hr(),

  tags$div(
    style = "padding: 0 15px;",
    tags$h5(style = "color: #b8c7ce; font-weight: bold;",
            icon("database"), " Dataset")
  ),

  selectInput("dataset", NULL, choices = DATASETS),
  selectInput("target",  "Target Variable", choices = NULL),

  uiOutput("feature_selector_ui"),

  sliderInput("split", "Train / Test Split",
    min = 0.5, max = 0.9, value = 0.8, step = 0.05, ticks = FALSE
  ),

  hr(),

  tags$div(
    style = "padding: 0 15px;",
    tags$h5(style = "color: #b8c7ce; font-weight: bold;",
            icon("cogs"), " Algorithm")
  ),

  selectInput("model_type", NULL, choices = c(
    "Random Forest"           = "rf",
    "Decision Tree"           = "dt",
    "Linear / Logistic Reg."  = "lm"
  )),

  conditionalPanel("input.model_type == 'rf'",
    div(style = "padding: 0 15px;",
      sliderInput("rf_ntree", "Number of Trees",
        min = 50, max = 500, value = 100, step = 50, ticks = FALSE),
      sliderInput("rf_mtry", "mtry (features/split)",
        min = 1, max = 10, value = 2, step = 1, ticks = FALSE)
    )
  ),

  conditionalPanel("input.model_type == 'dt'",
    div(style = "padding: 0 15px;",
      sliderInput("dt_maxdepth", "Max Depth",
        min = 1, max = 20, value = 5, step = 1, ticks = FALSE),
      numericInput("dt_minsplit", "Min Split",
        value = 20, min = 2, max = 100)
    )
  ),

  br(),

  div(style = "padding: 0 15px;",
    actionButton("train_btn",
      label = tagList(icon("play"), " Train Model"),
      class = "btn-success btn-lg btn-block"
    )
  )
)

body <- dashboardBody(
  tags$head(tags$style(HTML("
    body, .content-wrapper, .right-side {
      background-color: #f0f3f7 !important;
    }
    .box {
      border-radius: 6px;
      box-shadow: 0 1px 5px rgba(0,0,0,0.10);
    }
    .skin-blue .main-header .logo {
      background-color: #2c3e50;
      font-weight: bold;
      font-size: 20px;
      letter-spacing: 1px;
    }
    .skin-blue .main-header .logo:hover { background-color: #2c3e50; }
    .skin-blue .main-header .navbar { background-color: #34495e; }
    .skin-blue .sidebar { background-color: #2c3e50; }
    .skin-blue .sidebar-menu > li > a { color: #b8c7ce; }
    .skin-blue .sidebar-menu > li.active > a,
    .skin-blue .sidebar-menu > li:hover > a {
      background-color: #1a252f;
      border-left-color: #3498db;
      color: #fff;
    }
    .btn-success { background-color: #27ae60; border-color: #27ae60; }
    .btn-success:hover { background-color: #1e8449; border-color: #1e8449; }
    .small-box .icon-large { font-size: 90px !important; }
    hr { border-color: #3d5166; }
  "))),

  tabItems(

    # ── Data Explorer ──────────────────────────────────────────────────────
    tabItem("data",
      fluidRow(
        valueBoxOutput("vbox_nrow", width = 4),
        valueBoxOutput("vbox_ncol", width = 4),
        valueBoxOutput("vbox_task", width = 4)
      ),
      fluidRow(
        box(title = "Dataset Preview", width = 12,
          solidHeader = TRUE, status = "primary",
          DTOutput("data_table")
        )
      ),
      fluidRow(
        box(title = "Feature Distributions", width = 12,
          solidHeader = TRUE, status = "info",
          plotOutput("dist_plot", height = "380px")
        )
      )
    ),

    # ── Model Training ─────────────────────────────────────────────────────
    tabItem("train",
      fluidRow(
        box(title = "Configuration", width = 6,
          solidHeader = TRUE, status = "primary",
          verbatimTextOutput("config_summary")
        ),
        box(title = "Training Results", width = 6,
          solidHeader = TRUE, status = "success",
          verbatimTextOutput("train_results")
        )
      ),
      fluidRow(
        box(title = "Model Details", width = 12,
          solidHeader = TRUE, status = "info",
          verbatimTextOutput("model_details")
        )
      )
    ),

    # ── Performance ────────────────────────────────────────────────────────
    tabItem("perf",
      fluidRow(
        valueBoxOutput("vbox_metric1", width = 4),
        valueBoxOutput("vbox_metric2", width = 4),
        valueBoxOutput("vbox_metric3", width = 4)
      ),
      fluidRow(
        box(title = "Confusion Matrix / Residuals", width = 6,
          solidHeader = TRUE, status = "primary",
          plotOutput("cm_residual_plot", height = "360px")
        ),
        box(title = "Predicted vs Actual / Per-Class Accuracy", width = 6,
          solidHeader = TRUE, status = "info",
          plotOutput("pred_actual_plot", height = "360px")
        )
      )
    ),

    # ── Visualizations ─────────────────────────────────────────────────────
    tabItem("viz",
      fluidRow(
        box(title = "Variable Importance", width = 6,
          solidHeader = TRUE, status = "primary",
          plotOutput("varimp_plot", height = "420px")
        ),
        box(title = "Feature Scatter", width = 6,
          solidHeader = TRUE, status = "info",
          fluidRow(
            column(6, uiOutput("scatter_x_ui")),
            column(6, uiOutput("scatter_y_ui"))
          ),
          plotOutput("scatter_plot", height = "340px")
        )
      )
    )
  )
)

ui <- dashboardPage(header, sidebar, body, skin = "blue")

# ── Server ────────────────────────────────────────────────────────────────────
server <- function(input, output, session) {

  # ── Reactive: loaded dataset ───────────────────────────────────────────────
  rv_df <- reactive({
    load_dataset(input$dataset)
  })

  # ── Sync target selector when dataset changes ──────────────────────────────
  observeEvent(input$dataset, {
    df <- rv_df()
    updateSelectInput(session, "target",
      choices  = names(df),
      selected = names(df)[ncol(df)]
    )
  })

  # ── Dynamic feature checkboxes ─────────────────────────────────────────────
  output$feature_selector_ui <- renderUI({
    df    <- rv_df()
    feats <- setdiff(names(df), input$target)
    div(style = "padding: 0 15px;",
      tags$label("Features", class = "control-label"),
      checkboxGroupInput("features", NULL, choices = feats, selected = feats)
    )
  })

  # ── Derived: task type ─────────────────────────────────────────────────────
  task_type <- reactive({
    req(input$target)
    if (is_classification(rv_df()[[input$target]])) "classification" else "regression"
  })

  # ── Value boxes: Data tab ──────────────────────────────────────────────────
  output$vbox_nrow <- renderValueBox({
    valueBox(format(nrow(rv_df()), big.mark = ","),
      "Observations", icon = icon("list-ol"), color = "blue")
  })
  output$vbox_ncol <- renderValueBox({
    valueBox(ncol(rv_df()),
      "Variables", icon = icon("columns"), color = "green")
  })
  output$vbox_task <- renderValueBox({
    tt <- task_type()
    valueBox(
      ifelse(tt == "classification", "Classification", "Regression"),
      "Task Type",
      icon  = icon(ifelse(tt == "classification", "tags", "line-chart")),
      color = ifelse(tt == "classification", "purple", "orange")
    )
  })

  # ── Data table ─────────────────────────────────────────────────────────────
  output$data_table <- renderDT({
    datatable(rv_df(),
      options = list(pageLength = 10, scrollX = TRUE, dom = "frtip"),
      rownames = FALSE,
      class    = "compact stripe hover"
    )
  })

  # ── Feature distributions ──────────────────────────────────────────────────
  output$dist_plot <- renderPlot({
    df       <- rv_df()
    num_cols <- names(df)[vapply(df, is.numeric, logical(1))]
    num_cols <- head(num_cols, 6)
    if (length(num_cols) == 0) return(NULL)

    # Reshape to long format without tidyr
    df_long <- do.call(rbind, lapply(num_cols, function(col) {
      data.frame(Variable = col, Value = df[[col]], stringsAsFactors = FALSE)
    }))

    ggplot(df_long, aes(x = Value)) +
      geom_histogram(aes(y = after_stat(density)),
        bins = 20, fill = palette_blue, color = "white", alpha = 0.85) +
      geom_density(color = palette_red, size = 0.9) +
      facet_wrap(~Variable, scales = "free") +
      labs(x = NULL, y = "Density") +
      theme_minimal(base_size = 12) +
      theme(
        strip.text       = element_text(face = "bold", size = 11),
        panel.grid.minor = element_blank(),
        panel.spacing    = unit(1, "lines")
      )
  })

  # ── Training ───────────────────────────────────────────────────────────────
  model_res <- eventReactive(input$train_btn, {
    req(input$features, input$target)
    validate(need(length(input$features) >= 1, "Please select at least one feature."))

    df     <- rv_df()
    target <- input$target
    feats  <- input$features
    task   <- task_type()

    df_m <- df[, c(feats, target), drop = FALSE]
    if (task == "classification" && !is.factor(df_m[[target]])) {
      df_m[[target]] <- as.factor(df_m[[target]])
    }
    df_m <- na.omit(df_m)

    validate(need(nrow(df_m) >= 10,
      "Not enough data after removing NAs. Please choose a different dataset or features."))

    # Train / test split
    set.seed(42)
    n         <- nrow(df_m)
    train_idx <- sample(seq_len(n), size = max(5L, floor(input$split * n)))
    train     <- df_m[ train_idx, ]
    test      <- df_m[-train_idx, ]

    validate(need(nrow(test) >= 1, "No test samples. Try reducing the training split."))

    formula <- as.formula(
      paste0("`", target, "` ~ ", paste0("`", feats, "`", collapse = " + "))
    )

    t0 <- proc.time()["elapsed"]

    model <- switch(input$model_type,
      rf = {
        mtry_val <- min(input$rf_mtry, length(feats))
        randomForest(formula, data = train,
          ntree = input$rf_ntree, mtry = mtry_val)
      },
      dt = {
        rpart(formula, data = train,
          control = rpart.control(
            maxdepth = input$dt_maxdepth,
            minsplit = input$dt_minsplit
          ))
      },
      lm = {
        if (task == "regression") {
          lm(formula, data = train)
        } else {
          lvls <- levels(train[[target]])
          if (length(lvls) == 2) {
            glm(formula, data = train, family = binomial())
          } else {
            # Multi-class: fall back to decision tree
            rpart(formula, data = train)
          }
        }
      }
    )

    elapsed <- round(proc.time()["elapsed"] - t0, 3)

    # ── Predictions ──────────────────────────────────────────────────────────
    if (task == "classification") {
      if (inherits(model, "glm")) {
        probs <- predict(model, newdata = test, type = "response")
        lvls  <- levels(train[[target]])
        pred  <- factor(ifelse(probs > 0.5, lvls[2], lvls[1]), levels = lvls)
      } else {
        raw <- predict(model, newdata = test, type = "class")
        pred <- if (is.factor(raw)) raw else factor(raw)
      }
      actual   <- test[[target]]
      all_lvls <- union(levels(actual), levels(pred))
      actual   <- factor(actual, levels = all_lvls)
      pred     <- factor(pred,   levels = all_lvls)

      cm  <- table(Actual = actual, Predicted = pred)
      acc <- sum(diag(cm)) / sum(cm)

      # Per-class precision / recall → macro F1
      n_cls <- nrow(cm)
      f1_per <- vapply(seq_len(n_cls), function(i) {
        tp   <- cm[i, i]
        fp   <- sum(cm[, i]) - tp
        fn   <- sum(cm[i, ]) - tp
        prec <- if ((tp + fp) == 0) 0 else tp / (tp + fp)
        rec  <- if ((tp + fn) == 0) 0 else tp / (tp + fn)
        if ((prec + rec) == 0) 0 else 2 * prec * rec / (prec + rec)
      }, numeric(1))
      macro_f1 <- mean(f1_per)

      # Cohen's kappa
      p_e   <- sum(rowSums(cm) * colSums(cm)) / sum(cm)^2
      kappa <- if ((1 - p_e) == 0) NA else (acc - p_e) / (1 - p_e)

      list(
        model = model, task = task, cm = cm,
        acc = acc, kappa = kappa, macro_f1 = macro_f1,
        actual = actual, pred = pred, elapsed = elapsed,
        features = feats, target = target,
        train_n = nrow(train), test_n = nrow(test),
        model_type = input$model_type
      )

    } else {
      pred   <- as.numeric(predict(model, newdata = test))
      actual <- test[[target]]

      rmse   <- sqrt(mean((actual - pred)^2))
      mae    <- mean(abs(actual - pred))
      ss_res <- sum((actual - pred)^2)
      ss_tot <- sum((actual - mean(actual))^2)
      r2     <- 1 - ss_res / ss_tot

      list(
        model = model, task = task,
        rmse = rmse, mae = mae, r2 = r2,
        actual = actual, pred = pred, elapsed = elapsed,
        features = feats, target = target,
        train_n = nrow(train), test_n = nrow(test),
        model_type = input$model_type
      )
    }
  })

  # ── Config summary ─────────────────────────────────────────────────────────
  output$config_summary <- renderPrint({
    cat("Dataset  :", input$dataset, "\n")
    cat("Task     :", task_type(), "\n")
    cat("Target   :", input$target, "\n")
    cat("Features :", length(input$features), "selected\n")
    cat("          ", paste(input$features, collapse = ", "), "\n\n")
    cat("Split    :", paste0(input$split * 100, "% train / ",
                              round((1 - input$split) * 100), "% test"), "\n")
    algo <- switch(input$model_type,
      rf = paste0("Random Forest  (ntree=", input$rf_ntree,
                  ", mtry=", input$rf_mtry, ")"),
      dt = paste0("Decision Tree  (maxdepth=", input$dt_maxdepth,
                  ", minsplit=", input$dt_minsplit, ")"),
      lm = "Linear / Logistic Regression"
    )
    cat("Algorithm:", algo, "\n")
    cat("\nPress 'Train Model' to fit the model.\n")
  })

  # ── Training results ───────────────────────────────────────────────────────
  output$train_results <- renderPrint({
    res <- model_res()
    cat("=== Training Complete ===\n\n")
    cat(sprintf("Time elapsed  : %.3f sec\n", res$elapsed))
    cat(sprintf("Train samples : %d\n", res$train_n))
    cat(sprintf("Test  samples : %d\n\n", res$test_n))

    if (res$task == "classification") {
      cat(sprintf("Accuracy  : %.4f  (%.1f%%)\n", res$acc,  res$acc  * 100))
      cat(sprintf("Kappa     : %.4f\n",             res$kappa))
      cat(sprintf("Macro F1  : %.4f\n\n",           res$macro_f1))
      cat("Confusion Matrix:\n")
      print(res$cm)
    } else {
      cat(sprintf("RMSE  : %.4f\n", res$rmse))
      cat(sprintf("MAE   : %.4f\n", res$mae))
      cat(sprintf("R²    : %.4f\n", res$r2))
    }
  })

  # ── Model details ──────────────────────────────────────────────────────────
  output$model_details <- renderPrint({
    print(model_res()$model)
  })

  # ── Performance value boxes ────────────────────────────────────────────────
  output$vbox_metric1 <- renderValueBox({
    res <- model_res()
    if (res$task == "classification") {
      valueBox(paste0(round(res$acc * 100, 1), "%"),
        "Accuracy", icon = icon("check-circle"), color = "green")
    } else {
      valueBox(round(res$rmse, 4),
        "RMSE", icon = icon("arrows-h"), color = "blue")
    }
  })
  output$vbox_metric2 <- renderValueBox({
    res <- model_res()
    if (res$task == "classification") {
      valueBox(round(res$kappa, 3),
        "Kappa", icon = icon("balance-scale"), color = "blue")
    } else {
      valueBox(round(res$mae, 4),
        "MAE", icon = icon("calculator"), color = "orange")
    }
  })
  output$vbox_metric3 <- renderValueBox({
    res <- model_res()
    if (res$task == "classification") {
      valueBox(round(res$macro_f1, 3),
        "Macro F1", icon = icon("star"), color = "orange")
    } else {
      valueBox(round(res$r2, 4),
        "R\u00B2", icon = icon("line-chart"), color = "green")
    }
  })

  # ── Confusion matrix / Residuals ───────────────────────────────────────────
  output$cm_residual_plot <- renderPlot({
    res <- model_res()

    if (res$task == "classification") {
      cm_df <- as.data.frame(res$cm)
      # Darken tiles with higher counts
      ggplot(cm_df, aes(x = Predicted, y = Actual, fill = Freq)) +
        geom_tile(color = "white", size = 0.6) +
        geom_text(aes(label = Freq), size = 7, fontface = "bold",
          color = ifelse(cm_df$Freq > max(cm_df$Freq) / 2, "white", "#2c3e50")) +
        scale_fill_gradient(low = "#d6eaf8", high = "#1a5276") +
        labs(title = "Confusion Matrix", fill = "Count") +
        theme_minimal(base_size = 13) +
        theme(
          panel.grid   = element_blank(),
          axis.text    = element_text(face = "bold"),
          plot.title   = element_text(face = "bold", hjust = 0.5, size = 14)
        )
    } else {
      df_r <- data.frame(Fitted = res$pred, Residuals = res$actual - res$pred)
      ggplot(df_r, aes(x = Fitted, y = Residuals)) +
        geom_hline(yintercept = 0, linetype = "dashed",
          color = palette_red, size = 0.9) +
        geom_point(alpha = 0.6, color = palette_blue, size = 2.2) +
        geom_smooth(method = "loess", se = TRUE,
          color = "#e67e22", fill = "#f39c12", alpha = 0.15, size = 0.9) +
        labs(title = "Residuals vs Fitted",
          x = "Fitted Values", y = "Residuals") +
        theme_minimal(base_size = 13) +
        theme(
          panel.grid.minor = element_blank(),
          plot.title       = element_text(face = "bold", hjust = 0.5, size = 14)
        )
    }
  })

  # ── Predicted vs Actual ────────────────────────────────────────────────────
  output$pred_actual_plot <- renderPlot({
    res <- model_res()

    if (res$task == "regression") {
      df_pa <- data.frame(Actual = res$actual, Predicted = res$pred)
      lims  <- range(c(df_pa$Actual, df_pa$Predicted))

      ggplot(df_pa, aes(x = Actual, y = Predicted)) +
        geom_abline(slope = 1, intercept = 0, linetype = "dashed",
          color = palette_red, size = 0.9) +
        geom_point(alpha = 0.65, color = palette_blue, size = 2.5) +
        geom_smooth(method = "lm", se = FALSE,
          color = palette_green, size = 0.9) +
        coord_fixed(xlim = lims, ylim = lims) +
        labs(title = "Predicted vs Actual", x = "Actual", y = "Predicted") +
        theme_minimal(base_size = 13) +
        theme(
          panel.grid.minor = element_blank(),
          plot.title       = element_text(face = "bold", hjust = 0.5, size = 14)
        )
    } else {
      # Per-class accuracy bar chart
      cm_mat    <- as.matrix(res$cm)
      class_acc <- diag(cm_mat) / rowSums(cm_mat)
      acc_df    <- data.frame(
        Class    = names(class_acc),
        Accuracy = class_acc,
        stringsAsFactors = FALSE
      )
      ggplot(acc_df, aes(x = reorder(Class, Accuracy), y = Accuracy,
                         fill = Accuracy)) +
        geom_col(show.legend = FALSE, width = 0.6) +
        geom_text(aes(label = paste0(round(Accuracy * 100, 1), "%")),
          hjust = -0.1, size = 5, fontface = "bold") +
        scale_fill_gradient(low = palette_red, high = palette_green) +
        coord_flip(ylim = c(0, 1.18)) +
        labs(title = "Per-Class Accuracy", x = NULL, y = "Accuracy") +
        theme_minimal(base_size = 13) +
        theme(
          panel.grid.minor = element_blank(),
          plot.title       = element_text(face = "bold", hjust = 0.5, size = 14)
        )
    }
  })

  # ── Variable importance ────────────────────────────────────────────────────
  output$varimp_plot <- renderPlot({
    res   <- model_res()
    model <- res$model

    imp_df <- tryCatch({
      if (inherits(model, "randomForest")) {
        imp <- importance(model)
        col_idx <- ncol(imp)
        data.frame(Feature = rownames(imp),
          Importance = imp[, col_idx], stringsAsFactors = FALSE)

      } else if (inherits(model, "rpart")) {
        vi <- model$variable.importance
        if (is.null(vi) || length(vi) == 0L) stop("empty")
        data.frame(Feature = names(vi),
          Importance = as.numeric(vi), stringsAsFactors = FALSE)

      } else if (inherits(model, "lm") || inherits(model, "glm")) {
        coefs <- coef(model)
        coefs <- coefs[names(coefs) != "(Intercept)"]
        data.frame(Feature = names(coefs),
          Importance = abs(as.numeric(coefs)), stringsAsFactors = FALSE)

      } else {
        stop("unsupported model")
      }
    }, error = function(e) NULL)

    if (is.null(imp_df) || nrow(imp_df) == 0L) {
      return(
        ggplot() +
          annotate("text", x = 0.5, y = 0.5,
            label = "Variable importance not available\nfor this configuration.",
            size = 5, hjust = 0.5, color = "#666") +
          theme_void()
      )
    }

    max_imp <- max(imp_df$Importance)

    ggplot(imp_df, aes(x = reorder(Feature, Importance),
                       y = Importance, fill = Importance)) +
      geom_col(show.legend = FALSE) +
      geom_text(aes(label = round(Importance, 3)),
        hjust = -0.1, size = 4, fontface = "bold") +
      scale_fill_gradient(low = "#85c1e9", high = "#1a5276") +
      coord_flip(ylim = c(0, max_imp * 1.2)) +
      labs(title = "Variable Importance", x = NULL, y = "Importance") +
      theme_minimal(base_size = 13) +
      theme(
        panel.grid.minor = element_blank(),
        axis.text.y      = element_text(face = "bold"),
        plot.title       = element_text(face = "bold", hjust = 0.5, size = 14)
      )
  })

  # ── Scatter plot selectors ─────────────────────────────────────────────────
  numeric_features <- reactive({
    req(input$features)
    df    <- rv_df()
    num_f <- names(df)[vapply(df, is.numeric, logical(1))]
    intersect(input$features, num_f)
  })

  output$scatter_x_ui <- renderUI({
    nf <- numeric_features()
    selectInput("scatter_x", "X axis", choices = nf,
      selected = nf[1])
  })
  output$scatter_y_ui <- renderUI({
    nf <- numeric_features()
    selectInput("scatter_y", "Y axis", choices = nf,
      selected = if (length(nf) >= 2L) nf[2L] else nf[1L])
  })

  # ── Scatter plot ───────────────────────────────────────────────────────────
  output$scatter_plot <- renderPlot({
    req(input$scatter_x, input$scatter_y, input$target)
    df     <- rv_df()
    target <- input$target
    tt     <- task_type()

    df_plot <- data.frame(
      x     = df[[input$scatter_x]],
      y     = df[[input$scatter_y]],
      color = df[[target]],
      stringsAsFactors = FALSE
    )

    p <- if (tt == "classification") {
      ggplot(df_plot, aes(x = x, y = y, color = factor(color))) +
        scale_color_brewer(palette = "Set1", name = target)
    } else {
      ggplot(df_plot, aes(x = x, y = y, color = color)) +
        scale_color_gradient(low = "#85c1e9", high = "#1a5276", name = target)
    }

    p +
      geom_point(alpha = 0.72, size = 2.8) +
      labs(
        title = paste(input$scatter_x, "vs", input$scatter_y),
        x = input$scatter_x, y = input$scatter_y
      ) +
      theme_minimal(base_size = 13) +
      theme(
        panel.grid.minor = element_blank(),
        legend.position  = "bottom",
        plot.title       = element_text(face = "bold", hjust = 0.5, size = 14)
      )
  })
}

shinyApp(ui, server)

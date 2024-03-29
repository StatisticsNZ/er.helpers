# template1
# server.R

shinyServer(function(input, output, session) {
  ### plot ###

  plot_data <- reactive({
    # create a reactive plot_data object

    # add plot_data code from make_data_vis.R
    # change any placeholder character values to input widgets

    .color <- input$plot_color

    plot_data <- data1 %>%
      filter(color == .color) %>%
      mutate(cut = stringr::str_to_sentence(cut)) %>%
      group_by(cut, clarity, .drop = FALSE) %>%
      summarise(price = round(mean(price), 2)) %>%
      mutate_text(c("cut", "clarity", "price"))

    return(plot_data)
  })

  # output$plot_data <- DT::renderDT(
  #   plot_data(),
  #   filter = "top",
  #   rownames = FALSE,
  #   options = list(pageLength = 5, scrollX = TRUE, lengthChange = FALSE)
  # )

  plot_theme <- reactive({
    gg_theme(
      font = "helvetica",
      size_title = ifelse(input$isMobile == FALSE, 11, 16),
      size_body = ifelse(input$isMobile == FALSE, 10, 15),
      gridlines_v = TRUE
    )
  })

  plot <- reactive({
    # create a reactive ggplot object

    # add plot code from make_data_vis.R
    # change any placeholder character values to input widgets
    # refer to a reactive plot_data object as plot_data()

    req(plot_data())
    req(plot_theme())

    .color <- input$plot_color

    title <- glue::glue("Average diamond price of colour {.color} by cut and clarity")
    x_title <- "Average price ($US thousands)"
    y_title <- "Cut"

    plot <- gg_hbar_col(
      plot_data(),
      price,
      cut,
      clarity,
      text_var = text,
      title = title,
      x_title = x_title,
      y_title = y_title,
      col_labels = ggplot2::waiver(),
      title_wrap = title_wrap,
      theme = plot_theme(),
      mobile = input$isMobile
    )

    return(plot)
  })

  output$plot_desktop <- plotly::renderPlotly({
    plotly::ggplotly(plot(), tooltip = "text") %>%
      plotly_camera()
  })

  output$plot_mobile <- renderPlot({
    plot()
  })

  ### leaf ###
  output$leaf <- leaflet::renderLeaflet({

    if (input$isMobile == FALSE) {
      leaf_basemap %>%
        leaflet::addMiniMap(
          tiles = leaflet::providers$CartoDB.PositronNoLabels,
          position = "bottomleft",
          width = 100,
          height = 100,
          autoToggleDisplay = TRUE,
          toggleDisplay = TRUE,
          minimized = TRUE
        )
    } else
      return(leaf_basemap)
  })

  leaf_data <- reactive({
    # create a reactive leaf_data object

    leaf_filter <- input$leaf_filter

    if (leaf_filter == "None") {
      leaf_data <- data2
    } else if (leaf_filter != "None") {
      leaf_data <- data2 %>%
        filter(trend_category == leaf_filter)
    }

    return(leaf_data)
  })

  # output$leaf_data <- DT::renderDT(
  #   leaf_data(),
  #   filter = "top",
  #   rownames = FALSE,
  #   options = list(pageLength = 5, scrollX = TRUE, lengthChange = FALSE)
  # )

  leaf_draw <- function() {
    # add leaflet code from make_data_vis.R
    # change any placeholder character values to input widgets
    # refer to a reactive leaf_data object as leaf_data()
    # use reactive radius for points that get bigger as the user zooms in, if necessary

    size_reactive <- ifelse(input$leaf_zoom < 6, 1.5,
             ifelse(input$leaf_zoom < 7, 2,
                    ifelse(input$leaf_zoom < 8, 3, 4)))

    title <- paste0("Monitored trends, 2008\u201317")

    leaf_sf_col(
      leaf_data(),
      col_var = trend_category,
      size_point = size_reactive,
      col_title = title
    )
  }

  observe({
    req(leaf_data())
    req(input$leaf_zoom) # wait for baseleaf before plotting.

    withProgress(message = "Loading", {
      leaf_clear()
      leaf_draw()
    })
  })

  ### table ###

  table_data <- reactive({
    # create a reactive table_data object

    ggplot2::diamonds %>%
      select(carat:price) %>%
      rename_with(snakecase::to_sentence_case)
  })

  output$table <- DT::renderDT(
    table_data(),
    filter = "top",
    rownames = FALSE,
    options = list(pageLength = 10, scrollX = TRUE, lengthChange = FALSE)
  )

  ### download ###

  output$download <- downloadHandler(filename <- function() {
    "data.zip"   # add data.zip into the data subfolder using code in get_app_data.R
  },
  content <- function(file) {
    file.copy("data/data.zip", file)
  },
  contentType = "application/zip")

  ### download code ###

  output$download_code <- downloadHandler(filename <- function() {
    "template2.zip"
  },
  content <- function(file) {
    file.copy("data/template2.zip", file)
  },
  contentType = "application/zip")

})
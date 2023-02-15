#' #' Create a stacked bar chart to show proportions of responses by chosen aggregate
#' #'
#' #' Provides a stacked bar chart of the aggregated data for a question in the World Risk Poll.
#' #'
#' #' @param aggregation string, a demographic category by which to aggregate
#' #' @param survey_question string, the code for the survey question to focus on
#' #'
#' #' @importFrom ggplot2 ggplot geom_bar theme_minimal theme labs scale_fill_manual aes element_text
#' #' @importFrom dplyr mutate rename group_by ungroup summarise relocate case_when distinct desc
#' #' @importFrom labelled var_label is.labelled to_factor
#' #' @importFrom tidyr drop_na
#' #'
#' #' @return stacked bar chart of aggregated World Risk Poll question data
#' #' @export
#' #'
#' 
#' wrp_graph <- function(aggregation, survey_question) {
#' 
#'   df <- wrp::wrp_aggregate(aggregation, survey_question, TRUE) %>%
#'     drop_na(aggregation)
#' 
#'   plot <- ggplot(df, aes(x = weightedCount, y = aggregation, fill = response)) +
#'     geom_bar(stat = "identity", position = "fill") +
#'     theme_minimal() +
#'     theme(plot.title.position = "plot",
#'           plot.title = element_text(size = 12),
#'           legend.position = "top") +
#'     labs(x = "Proportion of respondents",
#'          y = NULL,
#'          fill = NULL) +
#'     scale_fill_manual(values = c("#1f77b4", "#aec7e8", "#ff7f0e", "#ffbb78", "#2ca02c",
#'                                  "#98df8a", "#b3292a", "#d62728",  "#ff9896", "#9467bd",
#'                                  "#c5b0d5", "#8c564b", "#c49c94", "#e377c2", "#f7b6d2",
#'                                  "#7f7f7f", "#c7c7c7", "#bcbd22", "#dbdb8d", "#17becf",
#'                                  "#9edae5"))
#' 
#'   print(df %>% distinct(question))
#' 
#'   show(plot)
#' 
#' }
#' 
#' #' Map the distribution of responses to chosen World Risk Poll questions
#' #'
#' #' Provides a map of the proportion of people in each country who responded to a
#' #' selected World Risk Poll question.
#' #'
#' #' @param survey_question string, the code for the survey question to focus on
#' #' @param survey_response string, the selected reponse to the chosen survey question
#' #'
#' #' @importFrom dplyr mutate rename group_by ungroup summarise relocate case_when filter left_join distinct
#' #' @importFrom labelled var_label
#' #' @importFrom rnaturalearth ne_countries
#' #' @importFrom ggplot2 ggplot geom_sf aes theme_void theme element_text labs scale_fill_steps
#' #'
#' #' @return map
#' #' @export
#' #'
#' 
#' wrp_map <- function(survey_question, survey_response) {
#' 
#'   wrp_df <- wrp_aggregate("country", survey_question, TRUE) %>%
#'     group_by(year, aggregation) %>%
#'     mutate(adm0_a3 = countrycode::countrycode(aggregation, "country.name", "iso3c", custom_match = c("Kosovo" = "KSV")),
#'            pct = weightedCount / sum(weightedCount) * 100) %>%
#'     filter(response == survey_response) %>%
#'     ungroup()
#' 
#'   plot <- ne_countries(scale = "medium", returnclass = "sf") %>%
#'     filter(sovereignt != "Antarctica") %>%
#'     left_join(wrp_df) %>%
#'     ggplot() +
#'     geom_sf(aes(fill = pct)) +
#'     theme_void() +
#'     theme(legend.position = "bottom",
#'           plot.title.position = "plot",
#'           plot.title = element_text(size = 11, face = "bold"),
#'           plot.subtitle = element_text(size = 11)) +
#'     labs(title = wrp_df %>% distinct(question),
#'          subtitle = paste0("Proportion of people in each country who responded \"", str_to_lower(survey_response), "\""),
#'          fill = NULL) +
#'     scale_fill_steps(low = "white", high = "#4F98D3")
#' 
#'   show(plot)
#' 
#' }

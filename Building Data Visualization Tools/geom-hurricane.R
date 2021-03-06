#' Build a wind radii geom for a storm observation 
#' 
#' \code(geom_hurrican) return a wind radii geom that shows essentially 
#' a polygon for each of the wind levels provided in the storm observation.
#' The polygon, for each wind level, uses the wind radii to calculate the 
#' points along the boundary of the polygon.
#' 
#' @section Aesthetics:
#' \code{geom_hurricane} understands the following aesthetics (required in bold):
#' \itemize{
#'   \item \strong{x}
#'   \item \strong{y}
#'   \item \strong{r_ne}
#'   \item \strong{r_se}
#'   \item \strong{r_nw}
#'   \item \strong{r_sw}
#'   \item colour
#'   \item fill
#'   \item size
#'   \item linetype
#'   \item alpha
#'   \item scale_radii
#' }
#' 
#' @inheritParams layer
#' 
#' @section Depends on:
#' \enumerate{
#'   \item \code{\link[ggplot2]{layer}} in the \code{ggplot2} package.
#' }
#'
#' @examples
#' \dontrun{
#' map_plot <- ggmap::get_map("Lousiana", zoom = 5, maptype = "toner-background") 
#' map_plot %>%
#'   ggmap::ggmap(extent = "device") +
#'   geom_hurricane(data = storm_observation_ike,
#'                  ggplot2::aes(x = longitude, y = latitude, 
#'                               r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
#'                               color = wind_speed, fill = wind_speed)) +
#'   ggplot2::scale_color_manual(name = "Wind speed (kts)", 
#'                               values = c("red", "orange", "yellow")) + 
#'   ggplot2::scale_fill_manual(name = "Wind speed (kts)", 
#'                              values = c("red", "orange", "yellow"))
#' }
#' @export
geom_hurricane <- function(mapping = NULL, data = NULL, stat = "identity",
                           position = "identitiy", na.rm = FALSE,
                           show.legend = NA, inherit.aes = TRUE, ...){
  
  ggplot2::layer(
    geom = GeomHurricane, mapping = mapping,
    data = data, stat = stat, position = position,
    show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}


#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomHurricane <- ggplot2::ggproto("GeomHurricane", ggplot2::Geom,
                         required_aes = c('x', 'y', 'r_ne', 'r_se','r_nw', 'r_sw'),
                         default_aes = ggplot2::aes(color ='NA', fill = 'grey20', size = 0.5,linetype = 1, alpha = 0.8, scale_radii = 1),
                         draw_key = ggplot2::draw_key_polygon,
                         draw_panel = function(data, panel_scales, coord){
                           point_obs = c(data[1,]$x, data[1,]$y)
                           color = data[1,]$color
                           alpha = data[1,]$alpha
                           fill = data[1,]$fill
                           scale_radii = data[1,]$scale_radii
                           
                           points_polygon = geosphere::destPoint(p = point_obs, b=1:90, d = data[1,]$r_ne * 1852 * scale_radii)
                           data_ne <- data.frame(x = c(points_polygon[,"lon"], point_obs[1]),
                                                 y = c(points_polygon[,"lat"], point_obs[2]))
                           
                           points_polygon = geosphere::destPoint(p = point_obs, b=90:180, d = data[1,]$r_se * 1852 * scale_radii)
                           data_se <- data.frame(x = c(points_polygon[,"lon"], point_obs[1]),
                                                 y = c(points_polygon[,"lat"], point_obs[2]))
                           
                           points_polygon = geosphere::destPoint(p = point_obs, b=180:270, d = data[1,]$r_sw * 1852 * scale_radii)
                           data_sw <- data.frame(x = c(points_polygon[,"lon"], point_obs[1]),
                                                 y = c(points_polygon[,"lat"], point_obs[2]))
                           
                           points_polygon = geosphere::destPoint(p = point_obs, b=270:180, d = data[1,]$r_nw * 1852 * scale_radii)
                           data_nw <- data.frame(x = c(points_polygon[,"lon"], point_obs[1]),
                                                 y = c(points_polygon[,"lat"], point_obs[2]))
                           
                           data_all <- rbind(data_ne, data_se, data_nw, data_sw)
                           
                           coords <- coord$transform(data_all, panel_scales)
                           
                           grid::polygonGrob(x = coords$x, y= coords$y, gp = grid::gpar(col = color, fill = fill, alpha = alpha))
                           
                         }
                        )



##Testing the geom : 'geom-hurricane' 

library(magrittr)
source('geom-hurricane.R')

#Get the storm observation from cleaned data
hurricane_data <- readr::read_csv(file = './data/ebtrk_atlc_1988_2015.cleaned.txt')
hurricane_data$wind_speed <- as.factor(hurricane_data$wind_speed)

storm_observation_ike <- hurricane_data[hurricane_data$storm_id == 'IKE-2008' &
                                          hurricane_data$date == lubridate::ymd_hms("2008-09-11 18:00:00"),]

storm_observation_ike_next <- hurricane_data[hurricane_data$storm_id == 'IKE-2008' &
                                               hurricane_data$date == lubridate::ymd_hms("2008-09-12 06:00:00"),]

png("hurricane_ike_2_observations.png")

map_plot <- ggmap::get_map("Lousiana", zoom = 6, maptype = "toner-background") 

map_plot %>%
  ggmap::ggmap(extent = "device") +
  geom_hurricane(data = storm_observation_ike,
                 ggplot2::aes(x = longitude, y = latitude, 
                              r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                              color = wind_speed, fill = wind_speed),scale_radii = 0.9) +
  geom_hurricane(data = storm_observation_ike_next,
                 ggplot2::aes(x = longitude, y = latitude, 
                              r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                              color = wind_speed, fill = wind_speed),scale_radii = 0.9) +
  ggplot2::scale_color_manual(name = "Wind speed (kts)", 
                              values = c("red", "orange", "yellow")) + 
  ggplot2::scale_fill_manual(name = "Wind speed (kts)", 
                             values = c("red", "orange", "yellow"))

dev.off()

png("hurricane_ike_observation.png")
map_plot <- ggmap::get_map("Lousiana", zoom = 5, maptype = "toner-background") 
map_plot %>%
  ggmap::ggmap(extent = "device") +
  geom_hurricane(data = storm_observation_ike,
                 ggplot2::aes(x = longitude, y = latitude, 
                              r_ne = ne, r_se = se, r_nw = nw, r_sw = sw,
                              color = wind_speed, fill = wind_speed)) +
  ggplot2::scale_color_manual(name = "Wind speed (kts)", 
                              values = c("red", "orange", "yellow")) + 
  ggplot2::scale_fill_manual(name = "Wind speed (kts)", 
                             values = c("red", "orange", "yellow"))
dev.off()

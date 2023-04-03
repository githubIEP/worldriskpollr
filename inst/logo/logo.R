library(tidyverse)
library(ggthemes)
library(hexSticker)
library(ggplot2)
library(ggpubr)
world <- map_data("world") %>% filter(region != "Antarctica")
worldmap <- ggplot(world, aes(x = long, y = lat, group = group), fill = NA) +
  geom_polygon() +
  scale_y_continuous(breaks = (-2:2) * 30) +
  scale_x_continuous(breaks = (-4:4) * 45) +
  coord_map("ortho",  orientation = c(51, 0, 20)) +
  theme_map() + theme(legend.position = "none") +
  theme_transparent()


hexSticker::sticker(
  subplot = worldmap, s_x = 1, s_y = 0.8, s_width = 1, s_height = 1,
  package = "worldriskpollr", p_x = 1, p_y = 1.4, p_size = 14, h_size = 1.2, p_family = "pf",
  p_color = "#3F8CCC", h_fill = "#FFF9F2", h_color = "#3F8CCC",
  dpi = 320, filename = "man/figures/logo.png"
)


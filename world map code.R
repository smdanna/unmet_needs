# creating world map using instructions from
# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf.html

install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel",
                   "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
                 
library("ggplot2")
theme_set(theme_bw())
library("sf")   

library("rnaturalearth")
library("rnaturalearthdata")
install.packages("rgeos")
library("rgeos")
library("ggplot2")

# saving map into object "world"
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)
View(world)

# checking out wtf ne_countries gives: data for creating a world map!
?ne_countries

# adding variable refcount, all 0 by default
# world$refcount <- NA   # for all NA 
world$refcount <- 0
View(world)

# changing values in world$refcount
world[1,"refcount"] <- 0
View(world)

# saving world to csv for physically printing out
# NONE OF THIS WORKED

write.csv(world,'world_df.csv')
write.table(x=world,file="world_df.csv",row.names = T,col.names = T,sep = ",")

# plotting basic map
ggplot(data = world) +
  geom_sf()

# with axis labels and title
ggplot(data = world) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("World map", subtitle = paste0("(", length(unique(world$NAME)), " countries)"))

# save the most recent map
ggsave("map.pdf")

# creating world map using instructions from
# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf.html

install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel",
                   "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))
install.packages("sf")
                 
library("ggplot2")
theme_set(theme_bw())
library("sf")   

library("rnaturalearth")
library("rnaturalearthdata")
# install.packages("rgeos")
library("rgeos")

# saving map into object "world"
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)
View(world)

# checking out wtf ne_countries gives: data for creating a world map!
?ne_countries

# adding variable refcount, all 0 by default
# world$refcount <- NA   # for all NA 
world$refcount <- 0
class(world$refcount)
world$refcount <- as.numeric(world$refcount)
View(world)
class(world$refcount)

# changing values in world$refcount
# world[1,"refcount"] <- 0   # example: changing the country in the first row to 0
world[15,"refcount"] <- 0    # 15 actually means the one before 15 in View() apparently
world[16,"refcount"] <- 1    # Australia has 1 reference
world[226,"refcount"] <- 0   # USA has 2 references
world[227,"refcount"] <- 2

View(world)

# saving world to csv for physically printing out
# NONE OF THIS WORKED
# 
# write.csv(world,'world_df.csv')
# write.table(x=world,file="world_df.csv",row.names = T,col.names = T,sep = ",")

# plotting basic map
ggplot(data = world) +
  geom_sf()

# with axis labels and title
ggplot(data = world) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("World map", subtitle = paste0("(", length(unique(world$NAME)), " countries)"))

# with fill according to refcount
ggplot(data = world) +
  geom_sf(aes(fill = refcount)) +
  scale_fill_distiller(palette="GnBu") +
  ggtitle("Provenance of included articles") + 
  theme(panel.grid.major = element_line(color = gray(.9), linetype = "dotted", size = 0.5), panel.background = element_rect(fill = "aliceblue")) +
  labs(fill="No. of articles")

# save the most recent map
ggsave("scale175.pdf",scale = 1.75)

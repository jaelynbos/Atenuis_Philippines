library(cowplot)
library(ggmap)
library(sf)
library(ggspatial)
library(tidyverse)

sites<-read.csv("all_Atenuis_sites.csv")
rels<-read.table("Sequoia_relatives.txt",header=TRUE)
rels$pairID<-seq(from=1,to=nrow(rels))
rels<-pivot_longer(rels,cols=c('Ind1','Ind2'),values_to='ID')
rels$Name<-unlist(lapply(strsplit(rels$ID,"_"), head, 1))

rels<-left_join(rels,sites)
rels$Taxon<-as.character(rels$Taxon)

ggmap::register_google("API_KEY_HERE",write=TRUE)
philippines<-get_googlemap(center=c(lon=124.4,lat=10.4),zoom=8,maptype="terrain",style = c('feature:administrative|element:labels|visibility:off'))
philippines2<-get_googlemap(center=c(lon=124,lat=12),zoom=6,maptype="satellite",style = c('feature:administrative|element:labels|visibility:off'))

taxon_colors  <- c("1"="#440154FF", "2"="#31688EFF","3"= "#35B779FF","4"= "#FDE725FF")

bbox <- st_bbox(c(xmin = 123.3, ymin = 9.4, xmax = 125.2, ymax = 11.4), crs = st_crs(4326))
p_main <- ggmap(philippines, darken = c(0.4, "white")) +
  coord_sf(xlim = c(123.3, 125.2), ylim = c(9.4, 11.4), expand = FALSE, crs = 4326) +
  annotation_scale(location = "br", width_hint = 0.5, pad_y = unit(1, "in"),
                   dist_unit = "km", transform = TRUE, model = "WGS84", text_cex = 2) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(size = 24),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 16),
    legend.text = element_text(size = 22)  # Doubled from default (~11) to 22
  ) +
  geom_point(data = rels, aes(x = LONGITUDE, y = LATITUDE, color = Taxon),
             size = 14) +  # Changed to 14
  scale_color_manual(values = taxon_colors) +
  ggtitle(NULL)
library(tidyverse)
library(ggforce)
library(ggmap)
library(sf)
library(ggplot2)
library(ggspatial)
library(grid)
library(viridis) 
library(cowplot)

sitecounts<-function(inds,col2){
  c<-data.frame(matrix(NA,nrow=length(unique(inds$Name)),ncol=2))
  colnames(c)<-c('Name','counts')
  c$Name<-names(table(inds$Name))
  c$counts<-as.vector(table(inds$Name)) 
  colnames(c)<-c('Name',col2)
  return(c)
}

DIR<-"C:/Users/jaely/Documents/Philippines_Atenuis"
sites<-read.csv("DIR/All_Atenuis_sites_FIXED.csv")
inds1<-read.csv("DIR/taxa1_inds_copy.csv",header=TRUE)
inds2<-read.csv("DIR/taxa2_inds_copy.csv",header=TRUE)
inds3<-read.csv("DIR/taxa3_inds_copy.csv",header=TRUE)
inds4<-read.csv("DIR/taxa4_inds_copy.csv",header=TRUE)

inds1$Name<-unlist(lapply(strsplit(inds1$x,"_"), head, 1))
inds2$Name<-unlist(lapply(strsplit(inds2$x,"_"), head, 1))
inds3$Name<-unlist(lapply(strsplit(inds3$x,"_"), head, 1))
inds4$Name<-unlist(lapply(strsplit(inds4$x,"_"), head, 1))

counts1<-sitecounts(inds1,'taxa1')
counts2<-sitecounts(inds2,'taxa2')
counts3<-sitecounts(inds3,'taxa3')
counts4<-sitecounts(inds4,'taxa4')

sitecounts<-left_join(sites,counts1)
sitecounts<-left_join(sitecounts,counts2)
sitecounts<-left_join(sitecounts,counts3)
sitecounts<-left_join(sitecounts,counts4)

sitecounts[is.na(sitecounts)]<-0
sitecounts$sum <- rowSums(sitecounts[,4:7])
sitecounts<-sitecounts[sitecounts$sum>0,]
ggmap::register_google("AIzaSyBSDRX2dDlggJr4ApEnuMftXXRQ_1WGPKs",write=TRUE)
philippines<-get_googlemap(center=c(lon=124.4,lat=10.4),zoom=8,maptype="terrain",style = c('feature:administrative|element:labels|visibility:off'))
philippines2<-get_googlemap(center=c(lon=124,lat=12),zoom=6,maptype="satellite",style = c('feature:administrative|element:labels|visibility:off'))

bbox <- st_bbox(c(xmin = 123.3, ymin = 9.4, xmax = 125.2, ymax = 11.4), crs = st_crs(4326))

p <- ggmap(philippines,darken = c(0.4, "white")) +
  coord_sf(xlim = c(123.3, 125.2), ylim = c(9.4, 11.4), expand = FALSE,crs = 4326) +
  geom_point(aes(x = LONGITUDE, y = LATITUDE), data = sitecounts, color="darkred", size = 8) +
  annotation_scale(location = "br", width_hint = 0.5,pad_y = unit(1,"in"),dist_unit = "km", transform = TRUE,  model = "WGS84",text_cex = 4) +
  #ggtitle("Cryptic taxa composition by site") + 
  xlab("Longitude") +
  ylab("Latitude") +
  theme_minimal() +
  theme(plot.title = element_text(size = 48),
        axis.title.x = element_text(size = 38),
        axis.title.y = element_text(size = 38),
        axis.text.x = element_text(size = 34),
        axis.text.y = element_text(size = 34))

ggsave(filename="DIR/bigmap_update.jpg",plot=p,width=12,height=16.65, device='jpeg', dpi=700)

#Make insert map

left <-123.3
bottom <-9.4
right <-125
top <-11.6

mm<-ggmap(philippines2) +
  geom_rect(
    aes(xmin = left, xmax = right, ymin = bottom, ymax = top),
    color = "red", fill = NA, linewidth = 1.5
  )

ggsave(filename="DIR/update_map.png",plot= mm,dpi=300,units='in',width=8,height=10)


#Making a legend in the stupidest possible way
data <- data.frame( 
  Xdata = rnorm(4), Ydata = rnorm(4), 
  LegendData = c("Taxa1","Taxa2","Taxa3","Taxa4")) 

gplot <- ggplot(data, aes(Xdata, Ydata, color = LegendData)) +   
  theme_minimal() + 
  scale_color_viridis(discrete = TRUE, option = "D") + 
  geom_point(size = 5)+
  theme_minimal() +
  labs(color = "Cryptic taxa")

leg <- get_legend(gplot)    
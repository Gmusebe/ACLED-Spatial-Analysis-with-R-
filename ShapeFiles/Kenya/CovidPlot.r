library(sf) 
library(leaflet) 
library(leaflet.providers)
library(RColorBrewer)


kenya_county <- st_read("/home/imusebe/code/R/Spatial Data Analysis and Visualisation/ShapeFiles/Kenya/Kenya Shapefiles/ken_admbnda_adm1_iebc_20191031.shp", 
                        stringsAsFactors = FALSE)
pathfile <- "/home/imusebe/code/R/Spatial Data Analysis and Visualisation/ShapeFiles/Kenya/covid.csv"
covid_data <- read.csv(pathfile, header = TRUE, na.strings = "")

pal <- colorNumeric(c("#a4a4a5", "#7e7e7f", "#a68097", "#7e6171", "#4a3340"), NULL)
COVID_COUNT <- log10(covid_data$No.of.cases)
leaflet(kenya_county) %>% addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
              fillColor = ~pal(log10(covid_data$No.of.cases)),
              label = ~paste0(covid_data$County, ": ", formatC(covid_data$No.of.cases, big.mark = ","))) %>%
  addLegend(pal = pal, values = ~COVID_COUNT, opacity = 1.0,
            labFormat = labelFormat(transform = function(x) round(10^x)))

pal <- colorRampPalette(brewer.pal(9,"Blues"))(length(covid_data))

pal <- colorNumeric(RColorBrewer::brewer.pal(9, "Blues"), NULL)
COVID_COUNT <- log10(covid_data$No.of.cases)
leaflet(kenya_county) %>% addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
              fillColor = ~pal(log10(covid_data$No.of.cases)),
              label = ~paste0(covid_data$County, ": ", formatC(covid_data$No.of.cases, big.mark = ","))) %>%
  addLegend(pal = pal, values = ~COVID_COUNT, opacity = 1.0,
            labFormat = labelFormat(transform = function(x) round(10^x)))

my_colors <- [2:4]
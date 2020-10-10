
text <- read.csv("D:\\CloudStation-ZS\\R\\guizhou-real-assets-scraping\\anshun_asset2020-10-10.csv", 
                 header = T, encoding = 'UTF-8')

  Encoding(text) <- "UTF-8"

ggplot(data = project_t) + geom_point(mapping = aes(x = ceti_no, y = average_price)， color = ) 


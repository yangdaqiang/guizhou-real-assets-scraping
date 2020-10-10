
text <- read.csv("D:\\CloudStation-ZS\\R\\guizhou-real-assets-scraping\\anshun_asset2020-10-10.csv", 
                 header = T, encoding = 'UTF-8')



ggplot(text, aes(x = presale, y = average_price, color = developer)) + geom_point()

text_small <- text %>% filter(average_price > 0, presale < 500)
  
ggplot(text_small, aes(x = presale, y = average_price, color = developer)) + geom_point()

ggplot(text_small, aes(x = presale, y = average_price)) + geom_point() + facet_wrap(~developer)


  

ggplot(data = text) + geom_point(mapping = aes(x = presale, y = average_price), color = developer) 



library(xml2)
library(rvest)
library(tidyverse)
library(DT)

base_url <- "http://as.gzfcxx.cn/House.aspx?page="

project_t <- data.frame()

# 1:X should change it manually
for (i in 1:10){
  myurl <- paste0(base_url, i)
  page_i <- read_html(myurl)
  
  developer_i<- html_nodes(page_i, ".Repeater tr:nth-child(4) td:nth-child(2)") %>% 
    html_text()
  proj_name_i <- html_nodes(page_i, ".Repeater table td:nth-child(2) .url") %>% 
    html_text()
  ceti_no_i <- html_nodes(page_i, "tr:nth-child(2) td:nth-child(2) div") %>% 
    html_text() %>% as.numeric()
  average_price_i <- html_nodes(page_i, "tr:nth-child(3) td:nth-child(4)") %>% 
    html_text() %>% as.numeric()
  sold_i <- html_nodes(page_i, ".Repeater table tr:nth-child(1) td:nth-child(6)") %>% 
    html_text() %>% as.numeric()
  presale_i <- html_nodes(page_i, "tr:nth-child(2) td:nth-child(6)") %>% 
    html_text() %>% as.numeric()
  locate_i<- html_nodes(page_i, "tr:nth-child(3) td:nth-child(2) div") %>% 
    html_text()
  
  #mediea_price_i <- html_nodes(page_i, "tr:nth-child(2) td:nth-child(4)") %>% html_text()
  #xinzhi_i <- html_nodes(page_i, ".Repeater table tr:nth-child(1) td:nth-child(4)") %>% html_text()
  
  project_i <- data.frame(developer = developer_i,
                          proj_name = proj_name_i,
                          ceti_no = ceti_no_i,
                          average_price = average_price_i,
                          sold = sold_i,
                          presale = presale_i,
                          locate = locate_i,
                          
                          #mediea_price = mediea_price_i,
                          #xinzhi = xinzhi_i,
                          
                          stringsAsFactors = FALSE)
  
  project_t <- rbind(project_t, project_i)
  
}

detail_i <- paste0("http://as.gzfcxx.cn/House/Sale.aspx?qu=%e5%ae%89%e9%a1%ba&yszh=", 

                   project_t$ceti_no, "&xmmc=", project_t$proj_name, "&zhlx=ys")

project_add <- data.frame()

for(j in 1:length(detail_i)){
  read_detail_j <- read_html(detail_i[j])
  bussiness_price_j <- html_nodes(read_detail_j, "tr:nth-child(3) td:nth-child(8) font") %>% 
    html_text() %>% as.numeric()
  
  house_price_j <- html_nodes(read_detail_j, "tr:nth-child(2) td:nth-child(8) font") %>% 
    html_text() %>% as.numeric()
  
  total_house_j <- html_nodes(read_detail_j, "#cph_hsi1_DG_sale_info tr:nth-child(2) td:nth-child(2)") %>% 
    html_text() %>% as.numeric()
  
  total_bussiness_j <- html_nodes(read_detail_j, "#cph_hsi1_DG_sale_info tr:nth-child(3) td:nth-child(2)") %>% 
    html_text() %>% as.numeric()
  
  left_house_j <- html_nodes(read_detail_j, "#cph_hsi1_DG_sale_info tr:nth-child(2) td:nth-child(5) font") %>% 
    html_text() %>% as.numeric()
  
  left_bussiness_j <- html_nodes(read_detail_j, "#cph_hsi1_DG_sale_info tr:nth-child(3) td:nth-child(5) font") %>% 
    html_text() %>% as.numeric()
  
  
  
  project_j <- data.frame(bussiness_price = bussiness_price_j,
                          house_price = house_price_j,
                          total_house = total_house_j,
                          total_bussiness = total_bussiness_j,
                          left_house = left_house_j,
                          left_bussiness = left_bussiness_j,
                          
                          stringsAsFactors = FALSE
                          
  )
  project_add <- rbind(project_add, project_j)
  
}

project_t <- cbind(project_t, project_add)


#rm(proj_name_i, ceti_no_i, locate_i, developer_i, average_price_i, sold_i, presale_i)


file_name <- paste0("anshun_asset", Sys.Date(), ".csv")

write.csv(project_t, file = file_name, row.names = FALSE, fileEncoding = "UTF-8")


write.csv(project_t, file = file_name, sep = ",", row.names = FALSE, fileEncoding = "UTF-8")






#str(project_t)

#DT::datatable(project_t)

# # constructure all pages of traget web
# url_page <- str_c(base_url, "page=", 1:3)
# 
# #url_page <- as.list(str_c(base_url, "page=", 1:56))
# 
# # 
# anshun_house <- vector("list", length(url_page))
# for(i in 1:length(url_page)){
# anshun_house[[i]] <- read_html(url_page[[i]])
# 
# }
# 
# project_name <- vector("list",length(url_page))
# for(j in 1:length(url_page)){
# project_name[[j]] <- html_nodes(anshun_house[[j]], ".Repeater table td:nth-child(2) .url") #html_text(project_name[[j]], trim = TRUE)
# }
# 
# head(project_name)
# 
# html_text(project_name, trim = TRUE)
# 
# #reference https://ask.hellobi.com/blog/R_shequ/33920
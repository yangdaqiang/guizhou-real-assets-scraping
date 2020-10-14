
library("XML")

library("data.table")

test <- "http://as.gzfcxx.cn/House/Info.aspx?qu=%e5%ae%89%e9%a1%ba&yszh=2020045&xmmc=%e6%be%b3%e7%bb%b4%e5%85%ac%e5%9b%ad%e7%a6%8f%e6%b9%be&zhlx=ys"


tbls <- readHTMLTable(test)

sale <- "http://as.gzfcxx.cn/House/Sale.aspx?qu=%e5%ae%89%e9%a1%ba&yszh=2019091&xmmc=%e6%97%b6%e4%bb%a3%e9%a1%ba%e5%9f%8e%e5%bb%ba%e8%ae%be%e9%a1%b9%e7%9b%ae&zhlx=ys"


sale_tbl <- readHTMLTable(sale, which = 1) %>% setDT()

sale_tbl_mid <- dcast(sale_tbl, id ~ "用途",  value.var = ("总套数", "合同均价"))




sale_tbl_new <- sale_tbl[ ,-1] 

sale_tbl_new <- c(sale_tbl_new[1,], sale_tbl_new[2,])


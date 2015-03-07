jewelry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

poultry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from POULTRY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

rice <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from RICE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

tobacco <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOBACCO"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))


jewelry_id <- unite(jewelry, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")
poultry_id <- unite(poultry, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")
rice_id <- unite(rice, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")
tobacco_id <- unite(tobacco, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")

megatable1 <- inner_join(jewelry_id, poultry_id, by = "ID")
megatable2 <- inner_join(rice_id, tobacco_id, by = "ID")

finaltable <- inner_join(megatable1, megatable2, by = "ID")
septable <- separate(finaltable, ID, into = c("AREA", "CONSUMPTIONSEGMENT", "COUNTRY"), sep = "_")
head(septable)

septable2 <- septable %>% select (AREA, CONSUMPTIONSEGMENT, COUNTRY, CONSUMPTIONINDOLLARS.x.x, TYPE.x.x )  %>% filter (CONSUMPTIONSEGMENT =="All")

septable3 <- spread(septable2, AREA, CONSUMPTIONINDOLLARS.x.x, fill = NA)

g <- ggplot(septable2, aes(x=COUNTRY, y= CONSUMPTIONINDOLLARS.x.x, AREA=legend)) + geom_point()
g

##############

q = "Urban"
z = "Rural"
m = "All"

outerjoinpoultry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from POULTRY where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

outerjoinpoultry2 <- spread(outerjoinpoultry, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

outerjoinrice <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from RICE where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

outerjoinrice2 <- spread(outerjoinrice, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

finalouter <- full_join(outerjoinpoultry2, outerjoinrice2, by = "COUNTRY")


###############
q = "Urban"
z = "Rural"
m = "All"

intersecttobacco <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOBACCO where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

intersecttobacco2 <- spread(intersecttobacco, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

intersectjewelry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

intersectjewelry2 <- spread(intersectjewelry, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

finalintersect <- left_join(intersecttobacco2, intersectjewelry2, by = "COUNTRY")

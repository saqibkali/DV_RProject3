q = "Urban"
z = "Rural"
m = "All"

intersecttobacco <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOBACCO where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

intersecttobacco2 <- spread(intersecttobacco, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

intersectjewelry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

intersectjewelry2 <- spread(intersectjewelry, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

finalintersect <- left_join(intersecttobacco2, intersectjewelry2, by = "COUNTRY")

colnames(finalintersect) <- c("ConsumptionSegment.x", "COUNTRY", "Type_Tobacco", "Rural_Tobacco", "Urban_Tobacco", "ConsumptionSegment.y", "Type_Jewelry", "Rural_Jewelry", "Urban_Jewelry")
head(finalintersect)

meltedfinalintersect <- melt(finalintersect, id.vars = "COUNTRY", measure.vars = c("Rural_Tobacco", "Rural_Jewelry", "Urban_Tobacco", "Urban_Jewelry"))


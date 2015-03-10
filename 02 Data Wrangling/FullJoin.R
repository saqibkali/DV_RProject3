
q = "Urban"
z = "Rural"
m = "All"

outerjoinpoultry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from POULTRY where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

outerjoinpoultry2 <- spread(outerjoinpoultry, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

outerjoinrice <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from RICE where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

outerjoinrice2 <- spread(outerjoinrice, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

finalouter <- full_join(outerjoinpoultry2, outerjoinrice2, by = "COUNTRY")

colnames(finalouter) <- c("ConsumptionSegment.x", "COUNTRY", "Type_Poultry", "Rural_Poultry", "Urban_Poultry", "ConsumptionSegment.y", "Type_Rice", "Rural_Rice", "Urban_Rice")
head(finalouter)
meltedfinalouter <- melt(finalouter, id.vars = "COUNTRY", measure.vars = c("Rural_Poultry", "Rural_Rice", "Urban_Poultry", "Urban_Rice"))

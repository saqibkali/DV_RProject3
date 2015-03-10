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

meltedseptable3 <- melt(septable3, id.vars = "COUNTRY", measure.vars = c("National", "Rural", "Urban"))
head(meltedseptable3)

meltedsepggplot <- ggplot(meltedseptable3, aes(x=COUNTRY, y=value, color=variable)) + geom_point() + facet_wrap(~COUNTRY)
meltedsepggplot

##############

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



meltedfinalggplot <- ggplot(meltedfinalouter, aes(x=COUNTRY, y=value, color=variable)) + geom_point() + facet_wrap(~COUNTRY)
meltedfinalggplot


###############
q = "Urban"
z = "Rural"
m = "All"

intersecttobacco <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOBACCO where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

intersecttobacco2 <- spread(intersecttobacco, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

intersectjewelry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY where (\\\"CONSUMPTIONSEGMENT\\\" = \\\'"m"\\\') and ((\\\"AREA\\\" = \\\'"q"\\\') or (\\\"AREA\\\" = \\\'"z"\\\'))"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q, z=z, m=m),verbose = TRUE)))

intersectjewelry2 <- spread(intersectjewelry, AREA, CONSUMPTIONINDOLLARS, fill = NA) %>% filter(Urban>Rural)

finalintersect <- left_join(intersecttobacco2, intersectjewelry2, by = "COUNTRY")

colnames(finalintersect) <- c("ConsumptionSegment.x", "COUNTRY", "Type_Tobacco", "Rural_Tobacco", "Urban_Tobacco", "ConsumptionSegment.y", "Type_Jewelry", "Rural_Jewelry", "Urban_Jewelry")

meltedfinalintersect <- melt(finalintersect, id.vars = "COUNTRY", measure.vars = c("Rural_Tobacco", "Rural_Jewelry", "Urban_Tobacco", "Urban_Jewelry"))
head(meltedfinalintersect)


meltedintersectggplot <- ggplot(meltedfinalintersect, aes(x=COUNTRY, y=value, color=variable)) + geom_point() + facet_wrap(~COUNTRY)
meltedintersectggplot

################
q='Urban'
r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY where \\\"AREA\\\" = \\\'"q"\\\'"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', q=q),verbose = TRUE)))



myplot1 <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram()
}


categoricals <- eval(parse(text=substring(gsub(",)", ")", getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from JEWELRY"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mks2426', PASS='orcl_mks2426', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE)), 1, 2^31-1)))

ddf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))


ll <- list()
for (i in names(ddf)) {   
  # For details on [[...]] below, see http://stackoverflow.com/questions/1169456/in-r-what-is-the-difference-between-the-and-notations-for-accessing-the
  if (i %in% categoricals[[2]]) {
    rr <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from JEWELRY group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    pp <- myplot1(rr,i)
    print(pp) 
    ll[[i]] <- pp
  }
}

png("/Users/saqibali/DataVisualization/DV_RProject3/categoricals2.png", width = 50, height = 20, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 12)))   

# print(l[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
# print(l[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
# print(l[[3]], vp = viewport(layout.pos.row = 1, layout.pos.col = 7:9))
# print(l[[4]], vp = viewport(layout.pos.row = 1, layout.pos.col = 10:12))
# print(l[[5]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:3))
# print(l[[6]], vp = viewport(layout.pos.row = 2, layout.pos.col = 4:6))
# print(l[[7]], vp = viewport(layout.pos.row = 2, layout.pos.col = 7:9))
# print(l[[8]], vp = viewport(layout.pos.row = 2, layout.pos.col = 10:12))

print(ll[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
print(ll[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
print(ll[[3]], vp = viewport(layout.pos.row = 1, layout.pos.col = 7:9))
print(ll[[4]], vp = viewport(layout.pos.row = 1, layout.pos.col = 10:12))
print(ll[[5]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:3))
print(ll[[6]], vp = viewport(layout.pos.row = 2, layout.pos.col = 4:6))
print(ll[[7]], vp = viewport(layout.pos.row = 2, layout.pos.col = 7:9))
print(ll[[8]], vp = viewport(layout.pos.row = 2, layout.pos.col = 10:12))

dev.off()
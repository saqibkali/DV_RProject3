
jewelry_id <- unite(jewelry, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")
poultry_id <- unite(poultry, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")
rice_id <- unite(rice, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")
tobacco_id <- unite(tobacco, "ID", c(AREA, CONSUMPTIONSEGMENT, COUNTRY), sep = "_")

megatable1 <- inner_join(jewelry_id, poultry_id, by = "ID")
megatable2 <- inner_join(rice_id, tobacco_id, by = "ID")

finaltable <- inner_join(megatable1, megatable2, by = "ID")
septable <- separate(finaltable, ID, into = c("AREA", "CONSUMPTIONSEGMENT", "COUNTRY"), sep = "_")


septable2 <- septable %>% select (AREA, CONSUMPTIONSEGMENT, COUNTRY, CONSUMPTIONINDOLLARS.x.x, TYPE.x.x )  %>% filter (CONSUMPTIONSEGMENT =="All")

septable3 <- spread(septable2, AREA, CONSUMPTIONINDOLLARS.x.x, fill = NA)
head(septable3)

meltedseptable3 <- melt(septable3, id.vars = "COUNTRY", measure.vars = c("National", "Rural", "Urban"))

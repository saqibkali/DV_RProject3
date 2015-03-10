meltedintersectggplot <- ggplot(meltedfinalintersect, aes(x=COUNTRY, y=value, color=variable)) + geom_point() + facet_wrap(~COUNTRY)
meltedintersectggplot
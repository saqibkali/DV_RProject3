meltedsepggplot <- ggplot(meltedseptable3, aes(x=COUNTRY, y=value, color=variable)) + geom_point() + facet_wrap(~COUNTRY)
meltedsepggplot
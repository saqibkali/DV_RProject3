meltedfinalggplot <- ggplot(meltedfinalouter, aes(x=COUNTRY, y=value, color=variable)) + geom_point() + facet_wrap(~COUNTRY)
meltedfinalggplot

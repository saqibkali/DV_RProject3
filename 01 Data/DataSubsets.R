jewelry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from JEWELRY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

poultry <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from POULTRY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

rice <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from RICE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

tobacco <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOBACCO"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='c##cs329e_mks2426',PASS='orcl_mks2426',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

# head(jewelry)
# head(poultry)
# head(rice)
# head(tobacco)

(tbl_df(jewelry))
(tbl_df(poultry))
(tbl_df(rice))
(tbl_df(tobacco))
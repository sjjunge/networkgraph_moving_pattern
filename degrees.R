install.packages("RODBC") 
library(RODBC) 
install.packages("sna")
library(sna)


driver.name <- "SQL Server"
db.name <- ""
host.name <- ""
port <-""
server.name <-""
user.name <- ""
pwd <- ""

con.text <- paste("DRIVER=",driver.name,
                  ";Database=",db.name,
                  ";Server=",server.name,
                  ";Port=",port,
                  ";PROTOCOL=TCPIP",
                  ";UID=", user.name,
                  ";PWD=",pwd,sep="")

con1 <- odbcDriverConnect(con.text)

links<- sqlQuery(con1, 'select * from _short_high_elder_basic_sido')
links_non<- sqlQuery(con1, 'select * from _short_high_elder_non_basic_sido')
node<- sqlQuery(con1, 'select * from _high_elder_r_nodes2_eng_new')


try<- sqlQuery(con1, 'select source,target from _high_elder_r_links2')
try_non<-sqlQuery(con1, 'select source, target from _high_elder_non_r_links2')

try_dt<-as.matrix(table(try),scale=FALSE)
try_non_dt<-as.matrix(table(try),scale=FALSE)


dt<-as.matrix(table(links),scale=F)
dt_result<-degree(dt,rescale=FALSE)
dt_result_in<-degree(dt,cmode="indegree",rescale=FALSE)
dt_result_out<-degree(dt,cmode="outdegree",rescale=TRUE)

dt_non<-as.matrix(table(links_non))
dt_non_result<-degree(dt_non,rescale=TRUE)
dt_non_result_in<-degree(dt_non,cmode="indegree",rescale=FALSE)
dt_non_result_out<-degree(dt_non,cmode="outdegree",rescale=FALSE)

barplot(dt_result)
barplot(dt_non_result)


write.csv(dt_result_in,"dt_result_in.csv",row.names=TRUE)
write.csv(dt_result_out,"dt_result_out.csv",row.names=TRUE)
write.csv(dt_non_result_in,"dt_non_result_in.csv",row.names=TRUE)
write.csv(dt_non_result_out,"dt_non_result_out.csv",row.names=TRUE)

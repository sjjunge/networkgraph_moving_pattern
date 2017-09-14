

install.packages("RODBC") 
library(RODBC) 
install.packages("sna")
library(sna)


##### CONNECTING MSSQL SERVER #####
driver.name <- "SQL Server"
db.name <- "dbname"
host.name <- "hostname"
port <-"port"
server.name <-"servername"
user.name <- "username"
pwd <- "password"

con.text <- paste("DRIVER=",driver.name,
                  ";Database=",db.name,
                  ";Server=",server.name,
                  ";Port=",port,
                  ";PROTOCOL=TCPIP",
                  ";UID=", user.name,
                  ";PWD=",pwd,sep="")

con1 <- odbcDriverConnect(con.text)


##### GET THE DATA FROM THE DATABASE #####
links<- sqlQuery(con1, 'select * from _high_elder_r_links')
node<- sqlQuery(con1, 'select * from _high_elder_r_nodes')


##### LIBRARY: igraph #####
library(igraph)
head(node)
head(links)
net <- graph_from_data_frame(d=links, vertices=node, directed=T) 
plot(net)


##### PLOT SETTINGS #####
colrs <- c("gray50", "tomato", "gold")
V(net)$color <- colrs[V(net)$type]
V(net)$size <-node$weight_4*4
V(net)$label.color <- "black"

V(net)$label <- V(net)$name
E(net)$width <- links$weight_2*15
E(net)$arrow.size <- .05
E(net)$edge.color <- "gray80"

E(net)$curved=.2
plot(net) 

l <- layout_on_sphere(net)
plot(net, layout=l)
legend(x=-1.5, y=-1.1, c("capital","megalopolis", "province"), pch=21,
       col="#777777", pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)
       
       
##### LIBRARY: RASTER #####
library("raster")
lo <- as.matrix(node[,7:8])
korea <- getData('GADM', country='KOR', level=1)
plot(korea)
plot(net, layout=lo, add = TRUE, rescale = FALSE)




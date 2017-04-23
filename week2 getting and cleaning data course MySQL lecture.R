##this will connect to an external website mysql meaning not the mysql on your
##computer

library("RMySQL")

ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;")
dbDisconnect(ucscDb)  ##this should return TRUE


hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)
length(allTables)

dbListFields(hg19,"affyU133Plus2")

dbGetQuery(hg19,"select count(*) from affyU133Plus2")

##affyData<-dbReadTable(hg19,"affyU133Plus2") ##get the entire table
##get a subset of the table
query<-dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMiss<- fetch(query)
quantile(affyMiss$misMatches)
dbClearResult(query)
dbDisconnect(hg19)



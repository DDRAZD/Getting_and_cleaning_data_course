

setwd("C:/Users/s4653591/Documents/DATA_SCIENCE/Getting_and_cleaning_data_course/")

if(!file.exists("data")){
        dir.create("data")
}
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

##on mac: download.file(url=fileurl, destfile = "./data/file1.csv", method = curl)
download.file(url=fileurl, destfile = "./data/file1.csv")
list.files("./data")
DateDownloaded<-date()

##read the data
housing<-read.table("./data/file1.csv", sep = ",", header = TRUE)
## value greater than $1,000,000 is coded as 24 in the VAL value
##read the column
VAL_values<-housing$VAL
VAL_non_NA_locations<-complete.cases(VAL_values)
VAL_non_NA<-VAL_values[VAL_non_NA_locations]
VAL_over_1MM<-VAL_non_NA==24
sum(VAL_over_1MM)

##Question 2:
##incorrect: tidy data has....internally consistent
##incorrect: each tidy....only one type of observation

##question 3: reading excel
excel_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
##on mac: download.file(url = excel_url,destfile = "./data/file2.xlsx",method = curl)
download.file(url = excel_url,destfile = "./data/file2.xlsx", mode = "wb")
##the addtion of the mode="wb" i found in the stackoverflow as otherwise the file is downloaded corrupt
DateDownloadedExcel<-date()
library(xlsx) ##had to do install.packages("xlsx") first and also needed to update java for rJava
colIndex<-7:15
rowIndex<-18:23

dat<-read.xlsx("./data/file2.xlsx",sheetIndex=1,header=TRUE,colIndex=colIndex,rowIndex = rowIndex)
## asked in the quesiton to evaluate this expression:
sum(dat$Zip*dat$Ext,na.rm=T)

##Question 4 -reading XML
xmlurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
library(XML) ##had to install.packages("XML")
##notice that before you downloaded a file to local and then read it, here, like, HTML or JSON
##you parse or read directly from the web with no interim step

##the actual URL did not seem to be xml so i added sub("s", "", fileURL) from stackoverflow
doc<-xmlTreeParse(sub("s", "", xmlurl),useInternal=TRUE)
rootNode<-xmlRoot(doc)
##go recurservly and pick up the zipcodes
zipcode<-xpathSApply(rootNode,"//zipcode",xmlValue)
answer<-sum(zipcode==21231)
##Question 5 - Data Tables 
file_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
library(data.table) ##had to install.packages("data.table")

download.file(url=file_url, destfile = "./data/file3.csv")
DT<-fread("./data/file3.csv") ## a substitute command to read.table that runs much faster
##using loops to increase time as windown system.time gives only in miliseconds and all comes out in zeros
answer1<-system.time(for(indeax in 1:100){DT[,mean(pwgtp15),by=SEX]})##the correct one as also uses the data.table (notice use of "by", which is a requirement in the question)
answer2<-system.time(for(indeax in 1:100){mean(DT$pwgtp15,by=DT$SEX)}) ##not the correct answer
answer3<-system.time(for(indeax in 1:100){tapply(DT$pwgtp15,DT$SEX,mean)})
answer4<-system.time(for(indeax in 1:100){sapply(split(DT$pwgtp15,DT$SEX),mean)})  ##not the correct answer
answer5<-system.time(for(indeax in 1:100){rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}) ##not the correct answer
answer6<-system.time(for(indeax in 1:100){mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
                     


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

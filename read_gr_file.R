library(dplyr)
library(sqldf)
require(stringi)

# When reading the data file, only keep the records that we're interested in
rawfile<-"goodreads_library_export.csv"
message("Reading data file")
#mydata<-read.csv.sql(rawfile,sql="select * from file where Exclusive.shelf in ('to-read','read')",header=TRUE)
data_raw<-read.csv(rawfile,header=TRUE)
closeAllConnections()

# Convert data frame to table frame for dplyr;
message("Preparing data file")
data_raw$Book.Id <- as.character(data_raw$Book.Id)
data_raw$Title <- as.character(data_raw$Title)
data_raw$ISBN <- as.character(data_raw$ISBN)
data_raw$ISBN <- gsub("\"","",data_raw$ISBN)
data_raw$ISBN <- gsub("=","",data_raw$ISBN)
data_raw$Date.Added <- as.POSIXct(data_raw$Date.Added,format="%Y/%m/%d")
data_raw$Date.Read <- as.POSIXct(data_raw$Date.Read,format="%Y/%m/%d")
#data_raw$My.Review <- as.character(data_raw$My.Review)
data_raw$My.Review.Length <- stri_length(data_raw$My.Review)
data_raw$Private.Notes <- as.character(data_raw$Private.Notes)
data_raw$Private.Notes <- gsub(":","",data_raw$Private.Notes)
data_raw$Audiobook.Length <- stri_match_first(data_raw$Private.Notes,regex="Length (.*?)<br/>")[,2]
data_raw$Audiobook.Length <- gsub(" hrs and ",":",data_raw$Audiobook.Length)
data_raw$Audiobook.Length <- gsub(" mins","",data_raw$Audiobook.Length)
AB.L <- stri_match_first(data_raw$Audiobook.Length,regex="(.*):(.*)")
data_raw$Audiobook.Time <- (as.numeric(AB.L[,2]) *60 + as.numeric(AB.L[,3])) / 60

data_raw$Series.Num <- stri_match_first(paste0(data_raw$Bookshelves,","),regex="z-series-(.*?),")[,1]
data_raw$Series.Num <- gsub("z-series-","Series #",data_raw$Series.Num)
data_raw$Series.Num <- gsub("-",".",data_raw$Series.Num)
data_raw$Series.Num <- gsub(",","",data_raw$Series.Num)
data_raw$Series.Num <- as.factor(data_raw$Series.Num)

#data_raw$Audiobook.Time <- strptime(data_raw_selected$Audiobook.Length,"%H hrs and %M mins")
#data_raw$Audiobook.Time <- as.numeric(as.difftime(data_raw_selected$Audiobook.Length,format="%H hrs and %M mins",units="hour"),units="hours")
data_raw$Audiobook.Narrator <- stri_match_first(paste(data_raw$Private.Notes,"<br/>"),regex="<br/>Narrated by (.*?)<",opts_regex=stri_opts_regex(case_insensitive=TRUE))[,2]

wanted_fields <- c("Book.Id","Title","Author.l.f","ISBN","My.Rating",
                   "Average.Rating","Binding","Number.of.Pages","Original.Publication.Year",
                   "Date.Read","Date.Added","Bookshelves","Exclusive.Shelf",
                   "Series.Num",
                   "My.Review.Length","Audiobook.Length", "Audiobook.Time",
                   "Audiobook.Narrator",
                   "Private.Notes","My.Review")

wanted_fields_debug <- c("Book.Id",
                   "Audiobook.Length", "Audiobook.Time",
                   "Private.Notes",
                   "Audiobook.Narrator","Title","Author.l.f")

data_raw_selected <- data_raw %>%
  select(one_of(wanted_fields))

#data_raw_selected$Book.Id <- paste0('https://www.goodreads.com/review/edit/',data_raw_selected$Book.Id)

read_books<-data_raw_selected[!is.na(data_raw_selected$Date.Read),]
read_books$shelf.days <- as.integer(read_books$Date.Read - read_books$Date.Added)
read_books$pub.year.date <- as.POSIXct(paste0(as.character(read_books$Original.Publication.Year),"/01/01"),format="%Y/%m/%d")
read_books$book.age.days <- as.integer(read_books$Date.Read - read_books$pub.year.date)
read_books$book.age.years <- as.integer((read_books$Date.Read - read_books$pub.year.date)/365.24)
read_books$before_after_gr <- as.factor(ifelse(sign(read_books$Date.Read - read_books$Date.Added)>=0,"AFTER","BEFORE"))
read_books$rating_error <- read_books$My.Rating - read_books$Average.Rating

unread_books<-data_raw_selected[is.na(data_raw_selected$Date.Read),]
read_goodreads <- read_books[read_books$Date.Read >= read_books$Date.Added,]
read_before_gr <- read_books[read_books$Date.Read < read_books$Date.Added,]




#filtered.data<-tbl_df(rawdata)
#%>%
  # The 'Date' and 'Time' fields are characters, convert them to a single Time field
#  mutate(DateTime = as.POSIXct(strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")))

# Clean up unnecessary files and variables
message("Cleaning temp items")
rm(AB.L)
rm(wanted_fields)
rm(wanted_fields_debug)
#rm(rawfile)
message("Data loaded, ready for processing")
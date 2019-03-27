# Reading in the NI Post Code file.
# With this command you can select the file to read although if required you could hardcode the path/file name
# I forced all blank spaces to NA to make it easier to manage that as I move forward
NIPostCodeSource <- read.csv(file.choose(), header=TRUE, na.strings=c("","NA"))


# The following command provides the data structure of the NIPostCodeSource data frame
# and printing the first 10 rows of the data from using the head() function
str(NIPostCodeSource, n = 10L)
head(NIPostCodeSource, n = 10L)

# The total number of missing values is shown with the summary command and it specifically lists the number of NA's
# Please note that for some data columns there are no NA's e.g. County, so NA's is not listed for that column.
summary(NIPostCodeSource)

# The request to return the mean missing values of the NIPOstcodedata doesn't make sense - need to discuss further.
# mean(NIPostCodeSource)

# For missing values I populated NA where no values were provided.   NA is the only logical value that could be provided.
# As County, x_coord and y_coord are all populated it may be possible to retreive key data like Town by joining with 
# some sort of mapping data but for this excercise leaving the values as NA and not removing them makes the most sense.


barplot(table(NIPostCodeSource$County))
table(NIPostCodeSource$County)

# Setting the County values as a categorizing factor using the as.factor command
NIPostCodeSource$County <- as.factor((NIPostCodeSource$County))

# moving the primary key to the start of the dataset using the following command
# First I do a head to show the order, then I reorder by moving the 15th attribute, PK, to the first column followed by the next 14

head(NIPostCodeSource, n = 2L)
NIPostCodeSource<-NIPostCodeSource[,c(15, 1:14)]
head(NIPostCodeSource, n = 2L)

# To filter out all records that have the text LIMAVADY in either Town, Townland or Locality I had to use the dplyr::filter package
# First I installed the package and then called the library and ran the filter to populate Limavady_Data
install.packages("dplyr")
library(dplyr)

temp = sapply(NIPostCodeSource["Town", "Townland", "Locality"],
              dplyr::filter(NIPostCodeSource), grepl("LIMAVADY", NIPostCodeSource, ingore.case = TRUE))

Limavady_Data <- dplyr::filter(NIPostCodeSource, grepl('LIMAVADY', Town, Townland, Locality))
Limavady_Data


write.csv(Limavady_Data, "CleanNIPostcodeData.csv")


# Reading in the Crime Data from the zip file

#crime_data <- read.table("NI Crime Data.zip", nrows=10, header=T, quote="\"", sep=",")

setwd("E:/DataScience/R/NI Crime Data/NI Crime Data")
getwd()


crime_files_list = list.files(pattern="*.csv",recursive = TRUE)
crime_files_list

for (i in 1:length(crime_files_list)) assign(crime_files_list[i], read.csv(crime_files_list[i]))

crime_file[1]

2015-01/2015-01-northern-ireland-street.csv


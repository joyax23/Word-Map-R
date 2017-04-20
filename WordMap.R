install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("textcat")


library(tm)
library(SnowballC)  
library(textcat)
library(wordcloud)





#Loading per Text file

#Set directory
setwd("G:/Sentiment Analysis/Web Scraping Data")
QP<-read.table("Data1.txt",header=FALSE,sep="\t")
QG<-read.table("Data2.txt",header=FALSE,sep="\t")
FQ<-read.table("Data3.txt",header=FALSE,sep="\t")


###***************************************************************************####
##LOADING
#Set directory

cname <- file.path("G:Sentiment Analysis/Web Scraping Data", "Joy")   
cname   
dir(cname)

#Load the R package for text mining and then load your texts into R.

docs <- Corpus(DirSource(cname)) 
summary(docs)



####Remove non english words********************************************
###*********************************************************************
###*********************************************************************




####***********************************************************************************


##PREPROCESSING***********************************************************************


#Removing special characters
for(j in seq(docs))   
{   
  docs[[j]] <- gsub("\\S+@\\S+", " ", docs[[j]])   
  #docs[[j]] <- gsub("?", " ", docs[[j]])   
  #docs[[j]] <- gsub("\\|", " ", docs[[j]])   
} 


#d<-gsub('\\S+@\\S+',"",docs) 

#Remove usernames
docs <- tm_map(docs, removePunctuation) 



#Removing numbers:

docs <- tm_map(docs, removeNumbers)   
docs<-tm_map(docs,removeWords,c("is","the","me"))

#Converting to lowercase:
#QP1 <- tolower(QP)  
docs <- tm_map(docs, tolower)   


#Removing "stopwords" (common words) that usually have no analytic value.
docs <- tm_map(docs, removeWords, stopwords("english")) 



#Stripping unnecesary whitespace from your documents:
docs <- tm_map(docs, stripWhitespace)   



#***********************doc becomes character from Corpus




#PROCESSING**********************************************************************
#To proceed, create a document term matrix.
#This is what you will be using from this point on.






#This tells R to treat your preprocessed documents as text documents.
docs <- tm_map(docs, PlainTextDocument)  
dtm <- DocumentTermMatrix(docs)   

#EXPLORE THE DATA, Frequency of Words
#freq <- colSums(as.matrix(dtm))   
#length(freq)   
#ordered_freq<-order(freq)
##OR


#Frequency of Words+
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)   
#head(freq, 14) 


#VIEW FREQUENCY
View(data.frame(freq))



#Create word cloud

set.seed(1234)
grayLevels<-gray((freq*10/(max(freq)*10)))
word.cloud<-wordcloud(words=names(freq),freq=freq,min.freq=10,random.order=F,colors=brewer.pal(8, "Spectral"))





#ADDITIONAL FILTER

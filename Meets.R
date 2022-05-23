library(RCurl)
library(XML)
library(stringr)
library(jsonlite)

#just get Olymmpics, meet type: 1

meetList <- list()
meetIdsAll <- c()

#grab link for parsing
html <- getURL(paste("https://www.swimrankings.net/index.php?page=meetSelect&selectPage=BYTYPE&meetType=1"))
doc <- htmlParse(html, asText = TRUE)

# gets only the meets with the green check mark for quality
qualities <- xpathSApply(doc, "//td[@class='name']/img", xmlGetAttr, 'src')[1:10]
hasQuality <- c()
for (q in qualities) {
    hasQuality <- c(hasQuality, str_detect(q, '5'))
}
count <- sum(hasQuality) + 1

#get the meet ids
links <- xpathSApply(doc, "//td[@class='name']/a", xmlGetAttr, 'href')[1:count]
meetIds <- c()
for (link in links) {
    id <- unlist(str_split(link, "="))[2] #https://www.swimrankings.net/index.php?page=meetDetail&meetId=626385
    meetIds <- c(meetIds, id)
}

meets <- xpathSApply(doc, "//table[@class='meetSearch']/tr", xmlValue)[2:count];
for(i in 1:length(meets)) {
    meet <- meets[i];
    
}
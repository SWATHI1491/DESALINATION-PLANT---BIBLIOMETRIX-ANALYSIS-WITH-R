#LOAD bibliometrix

library(bibliometrix)

## Data loading and converting

file <- c("D:\\Certificates\\R\\Desalination Plant\\Desalination Plant.bib")

M <- convert2df(file = file, dbsource = "scopus", format = "bibtex")

## Check completeness of metadata included in the bibliographic data frame

com <- missingData(M)
com$mandatoryTags


## Bibliometric Analysis

results <- biblioAnalysis(M, sep = ";")

##summary

S <- summary(object = results, k = 10, pause = FALSE)

## Some basic plots

plot(x = results, k = 10, pause = FALSE)


## Bibliographic network matrices: following code calculates a classical co-citation network

NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ";")


# Create a country collaboration network
M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")
# Plot the network
net=networkPlot(NetMatrix, n = dim(NetMatrix)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.8)


# Create a co-citation network

NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", n=30, sep = ";")

# Plot the network
net=networkPlot(NetMatrix, Title = "Co-Citation Network", type = "fruchterman", size=T, remove.multiple=FALSE, labelsize=0.7,edgesize = 5)


# Create keyword co-occurrences network

NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Co-occurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)



# Conceptual Structure using keywords (method="CA")

CS <- conceptualStructure(M,field="ID", method="MCA", minDegree=10, clust=5, stemming=FALSE, labelsize=15, documents=20, graph=FALSE)
plot(CS$graph_terms)




plot(CS$graph_dendogram)




# Create a historical citation network

histResults <- histNetwork(M, sep = ";")

# Plot a historical co-citation network
net <- histPlot(histResults, n=20, size = FALSE,label="short")

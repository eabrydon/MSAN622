library('ggplot2')
library('rjson')
#subset data to make sure all titles have an listed budget and mpaa rating
budget <- subset(movies, budget > -1)
ratings <- subset(movies, votes > 100)
rating <- subset(ratings, grepl('.+', mpaa))
rating <- subset(rating, year > 1998)

#remove the r1-10 columns because they don't really mean much
less <- rating[-c(7:16)]
rownames(less) <- paste(less$title,less$year)

#function to trim whitespace off entries
trim <- function (x) {
  return(gsub("^\\s+|\\s+$", "", x))
}

#make df into list object to de-dummy genre
l <- function(row) {
  gen <- c()
  if (row[8] == 1) {
    gen <- c(gen, 'Action')
  }
  if (row[9] == 1) {
    gen <- c(gen, 'Animation')
  }
  if (row[10] == 1) {
    gen <- c(gen, 'Comedy')
  }
  if (row[11] == 1) {
    gen <- c(gen, 'Drama')
  }
  if (row[12] == 1) {
    gen <- c(gen, 'Documentary')
  }
  if (row[13] == 1) {
    gen <- c(gen, 'Romance')
  }
  if (row[14] == 1) {
    gen <- c(gen, 'Short')
  }
  return(list(Title = row[[1]], Year = row[[2]], Length = trim(row[[3]]), Budget = trim(row[[4]]), Rating = row[[5]],
              Votes = trim(row[[6]]), MPAA = row[[7]], Genres=gen))
}
lists <- apply(less, MARGIN = 1, l) 

#write to a JSON file
sink("movies.json")
cat(toJSON(lists))
sink()

less <- apply(less, MARGIN = c(1,2), trim)

write.csv(
  less, 
  file = "movies.csv", 
  row.names = T
)

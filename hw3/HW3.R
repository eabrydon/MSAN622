sb <- Seatbelts
head(sb)

sb <- as.data.frame(Seatbelts, row.names = NULL)
#this is BULLSHIT!!!!!!!
mons <- c('01 Jan','01 Feb','01 Mar','01 Apr','01 May','01 Jun','01 Jul','01 Aug','01 Sep','01 Oct','01 Nov','01 Dec')
years <- 1969:1984

months <- sapply(years, function(y)
  sapply(mons, function(m)
    paste(m, y, sep=" ")))
ms <- paste(months, sep = " ")
# ms <- sapply(ms, function(x)
#   as.Date(x, format = '%d %b %Y'))
sb$date <- ms
sb$total <- sb$drivers + sb$front + sb$rear

write.csv(
  sb, 
  file = "seatbelts.csv", 
  row.names = FALSE
)

sbline <- sb[c('date', 'total', 'drivers','front','rear','kms')]

write.csv(
  sbline,
  file = 'sbline.csv',
  row.names = F)


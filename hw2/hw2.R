df <- data.frame(
  state.name,
  state.abb,
  state.x77,
  state.region,
  state.division,
  row.names = NULL
)
names(df) <- c("name","abbr", 'pop','income','illiteracy',"lifespan",
               "murder", "HS_grad","frost_days","area","NSEW","region")
write.csv(
  df, 
  file = "states.csv", 
  row.names = FALSE
)
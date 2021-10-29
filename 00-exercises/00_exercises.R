#Exercise 1. Extract from the Pets database 
#the daily number of procedures from the ProceduresHistory table

library(dplyr)

conn <- DBI::dbConnect(RSQLite::SQLite(), "~/data/pets.sqlite") 

DBI::dbListTables(conn)

tbl(conn, "ProceduresHistory")

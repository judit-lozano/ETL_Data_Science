# install.packages("dbplyr")
library(dplyr)

# Creamos una base de datos en memoria.
conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

# Con dplyr podemos subir una tabla a la base de datos. 
# En este caso, nuestra tabla en un dataframe predefinido en R.
copy_to(conn, mtcars)
DBI::dbListTables(conn)

# Evaluación perezosa

summary <- tbl(conn, "mtcars") %>% 
  group_by(cyl) %>% 
  summarise(mpg = mean(mpg, na.rm = TRUE)) %>% 
  arrange(desc(mpg))

# summary

summary %>% show_query()

# execute query and retrieve results
summary %>% collect()

own_query <- tbl(conn, sql("SELECT * FROM mtcars LIMIT 10"))
own_query

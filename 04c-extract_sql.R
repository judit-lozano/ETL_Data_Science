# install.packages("dbplyr") tiene que estar instalado pero no hace falta llamarlo
library(dplyr)

# Creamos una base de datos en memoria.
conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:") #con DBI lo podemos hacer todo, conexion y dataframes

# Con dplyr podemos subir una tabla a la base de datos. 
# En este caso, nuestra tabla en un dataframe predefinido en R.
copy_to(conn, mtcars)
DBI::dbListTables(conn)

# Evaluación perezosa

tbl(conn, "mtcars") %>% 
  group_by(cyl) %>% 
  summarise(mean_mpq = mean(mpg))

#Como plantear una operacion ventana con dplyr
#contra una base de datos
tbl(conn, "mtcars") %>% 
  group_by(cyl) %>% 
  mutate(std = (mpg - mean(mpg))) %>% 
  select(std)
           

summary <- tbl(conn, "mtcars") %>% 
  group_by(cyl) %>% 
  summarise(mpg = mean(mpg, na.rm = TRUE)) %>% 
  arrange(desc(mpg))

summary #ejecucion lazy
collect(summary) #para llamar a la tabla entera

# summary

summary %>% show_query()

# execute query and retrieve results
summary %>% collect()

own_query <- tbl(conn, sql("SELECT * FROM mtcars LIMIT 10"))
own_query


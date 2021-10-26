library(readxl)
path_to_file <- "~/data/ejemplos_lectura.xlsx" #cambio .. por ~ para absoluto (~) cargar la carpeta, en relativo seria sin ~
df_ejemplos <- read_xlsx(path_to_file) #ojo leo solo la parte que me interesa. Por defecto el programa lee la primera hoja esté en oculo o no.
df_ejemplos

# Hay hojas ocultas
excel_sheets(path_to_file)

# Para leer una hoja en concreto
df_ejemplos <- read_xlsx(path_to_file, sheet = "Fechas")
df_ejemplos

# Para leer regiones
df_fechas <- read_xlsx(path_to_file, 
                       sheet = "Fechas", 
                       skip = 2, 
                       col_types = c(rep("skip", 3), rep("guess", 5)))

df_fechas

# Para fechas más complicadas, trabajaremos con dplyr
df_chungo <- read_xlsx(path_to_file, sheet = "Holi")
df_chungo
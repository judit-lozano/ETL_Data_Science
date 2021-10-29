
#Ejercicio 3: We want a table that includes all the adjusted polls for Trump and 
#Clinton in the Ohio and Pennsylvania states, along with the final results, 
#order from the newest poll to the oldest (considering only the enddate column).

# Conectamos a la base de datos
from sqlalchemy import create_engine
engine = create_engine('sqlite:///data/elections2016.sqlite')

# Trabajaremos con pandas
import pandas as pd

# Exploración de tablas
from sqlalchemy import inspect
inspector = inspect(engine)
print(inspector.get_table_names())

# Cargamos en un DataFrame el resultado de una query SQL
table_polls = pd.read_sql('SELECT * FROM Polls', engine)
table_polls.head()
table_results = pd.read_sql('SELECT * FROM Results', engine)
table_results.head()

query = """
  SELECT Polls.state, Polls.enddate, Polls.grade, Polls.samplesize,
  Polls.adjpoll_clinton, Polls.adjpoll_trump,
  Results.electoral_votes, Results.clinton, Results.trump
  FROM Polls INNER JOIN Results
      ON Polls.state = Results.state
  WHERE Polls.state in ('Ohio', 'Pennsylvania')
  ORDER BY Polls.enddate ASC
"""

final_table = pd.read_sql(query, engine)
final_table.head()


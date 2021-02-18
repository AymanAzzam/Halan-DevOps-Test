import psycopg2
from psycopg2 import Error

from flask import Flask, request, jsonify

app = Flask(__name__)

def connect_db():
    try:
        # connect to the database
        connection = psycopg2.connect(database="halan")
        # Print PostgreSQL Server Info
        print("PostgresSQL Server info: ", connection.get_dsn_parameters(),"\n")
        return connection
    except (Exception, Error) as e:
        print("Error while connecting to PostgresSQL\n", e)
        return None

def disconnect_db(connection):
    connection.close()
    print("PostgresSQL connection is closed")

def run_insert(connection, query):
    # cursor to perform the database operations
    cursor = connection.cursor() 
    # Run Query
    cursor.execute(query)
    connection.commit()
    cursor.close()

def run_select(connection, query):
    # cursor to perform the database operations
    cursor = connection.cursor() 
    # Run Query
    cursor.execute(query)
    # Fetch the results
    records = cursor.fetchall()
    cursor.close()
    return records
        
@app.route('/')
def home():
    n = request.args.get('n')
    if(n):
        # convert n from string to int
        n = int(n)
        # multiply n*n
        n *= n 
        # convert n to string again
        n = str(n)
        return n

    return "Halan Rocks"

@app.route('/<ip>')
def add_ip(ip):
    # save the ip on the database
    connection = connect_db()
    if(connection):
        query = "insert into ips (ip) values (\'"+ip+"\');"
        run_insert(connection,query)
        disconnect_db(connection)
        return ip+" is saved in the database"
    else:
        return "There is an error in PostrgrsSQL Connection"

@app.route('/allips')
def get_ips():
    # retrieve all ips from the database
    connection = connect_db()
    if(connection):
        query = "select * from ips"
        records = run_select(connection, query)
        disconnect_db(connection)
        return jsonify(records)
    else:
        return "There is an error in PostrgrsSQL Connection"

if __name__ == '__main__':
    app.run()
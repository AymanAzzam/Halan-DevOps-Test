import sys

import psycopg2
from psycopg2 import Error

from flask import Flask, request, jsonify

app = Flask(__name__)

def connect_db():
    db_name = sys.argv[1]
    try:
        # connect to the database
        connection = None
        if(len(sys.argv) > 2):
            db_password = sys.argv[2]
            db_host = sys.argv[3]
            connection = psycopg2.connect(database=db_name, password=db_password, host=db_host)
        else:
            connection = psycopg2.connect(database=db_name)
        # Print PostgreSQL Server Info
        print("\nPostgresSQL Server info: \n", connection.get_dsn_parameters(),"\n")
        return connection
    except (Exception, Error) as e:
        print("\nError while connecting to PostgresSQL\n", e)
        return None

def disconnect_db(connection):
    connection.close()
    print("PostgresSQL connection is closed\n")

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
    print("ip request\n")
    if(ip == "favicon.ico"):    return ""
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
    print("allips request\n")
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
    if(len(sys.argv) > 4 or len(sys.argv) < 2):
        print("Unvalid Number of argumnts")
        print("the arguments are databse_name, databse_password(optional), databse_host(optional)")
    else:
        app.run(host='0.0.0.0')

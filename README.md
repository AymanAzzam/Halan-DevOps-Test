# Halan-DevOps-Test

### App

##### Databse
The machine that contain the database should has [PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/) installed
to create the database run the script create_db.sh from App directory
```sh
./create_db.sh
```

##### Run the App using app.py
First we need to prepare the app environment. Run the following commands from App directory
```sh
python -m venv env
source env/bin/activate
sudo apt-get install -y python-pip python-dev libpq-dev
pip install -r requirements.txt
```

To run the app file from App directory there are two methods
```sh
python app.py halan
``` 
Or
```sh
python app.py halan postgres 123456789 test@test.com
```
where "halan" is the database name, "postgres" is the database user, "123456789" is the database password and "test@test.com" is the database host

##### Run the App using Docker Image
to get the docker image, there are two methods. the firs one is to run the Dockerfile from App directory
```sh
docker build -t halan .
```
and the second one is to pull it from docker hub
```sh
docker pull aymanazzam/halantest:halan
```
then to run the image use one of the following methods based on your case local/production
```sh
docker run -p 5000:5000 halan python app.py halan
```
Or
```sh
docker run -p 5000:5000 halan python app.py halan postgres 123456789 test@test.com
```
where "halan" is the database name, "postgres" is the database user, "123456789" is the database password and "test@test.com" is the database host

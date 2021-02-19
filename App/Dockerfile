FROM ubuntu:16.04

ARG db_name
ARG db_password
ARG db_host
ARG db_user

WORKDIR /app

COPY . /app

RUN apt-get update -y && apt-get install -y python-pip python-dev libpq-dev

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["app.py", $db_name, $db_user, $db_password, $db_host]

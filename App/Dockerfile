FROM ubuntu:16.04

ARG db_name="halan"
ARG db_password
ARG db_host

WORKDIR /app

COPY . /app

RUN apt-get update -y && apt-get install -y python-pip python-dev libpq-dev

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["app.py", $db_name, $db_password, $db_host]

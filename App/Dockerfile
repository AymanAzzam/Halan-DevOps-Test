FROM ubuntu:16.04

WORKDIR /app

COPY . /app

RUN apt-get update -y && apt-get install -y python-pip python-dev libpq-dev

RUN pip install -r requirements.txt

ENTRYPOINT ["python"]

CMD ["app.py"]

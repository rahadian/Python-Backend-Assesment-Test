FROM python:3.10
WORKDIR /var/www/backend
COPY ./app ./app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
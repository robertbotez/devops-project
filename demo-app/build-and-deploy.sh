#!/bin/bash

cd sa-frontend
docker build -t robertbotez/sentiment-analysis-frontend .
cd ../sa-logic
docker build -t robertbotez/sentiment-analysis-logic:local .
cd ../sa-webapp
docker build -t robertbotez/sentiment-analysis-web-app
cd ..

docker push robertbotez/sentiment-analysis-frontend
docker push robertbotez/sentiment-analysis-logic:local
docker push robertbotez/sentiment-analysis-web-app

sudo docker stack deploy -c docker-compose.yaml my-app

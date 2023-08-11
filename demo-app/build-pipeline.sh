#!/bin/bash

cd sa-frontend
sudo docker build -t robertbotez/sentiment-analysis-frontend .
cd ../sa-logic
sudo docker build -t robertbotez/sentiment-analysis-logic:local .
cd ../sa-webapp
sudo docker build -t robertbotez/sentiment-analysis-web-app
cd ..

sudo docker push robertbotez/sentiment-analysis-frontend
sudo docker push robertbotez/sentiment-analysis-logic:local
sudo docker push robertbotez/sentiment-analysis-web-app

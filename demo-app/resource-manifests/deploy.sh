#!/bin/bash

kubectl create -f sa-frontend-manifest.yaml -f sa-logic-manifest.yaml -f sa-web-app-manifest.yaml

#!/bin/bash

helm repo add demo-app https://registry.cloud.utcluj.ro/chartrepo/demo-app
helm install my-app demo-app/helm-chart

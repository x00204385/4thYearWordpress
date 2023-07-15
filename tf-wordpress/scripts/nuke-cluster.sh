#!/bin/bash
#
PROJECT_DIR=${HOME}/Develop/TUDAWS/4thYearWordpress
RETAIL_APP="${PROJECT_DIR}/k8s/retail-app"
DASHBOARD_APP="${PROJECT_DIR}/k8s/dashboard"

# Show where we are
#
kubectl config current-context
#
kubectl delete -k ${RETAIL_APP}/manifests
#
# Remove the dashboard
#
kubectl delete -k ${DASHBOARD_APP}

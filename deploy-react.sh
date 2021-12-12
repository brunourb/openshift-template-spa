#!/usr/bin/env bash

#oc delete template/fatesg-react -n fatesg-v1
#oc delete all -l app=react-fatesg
#oc delete secrets -l=app=react-fatesg
#oc create -f fatesg-nginx-template.yaml -n fatesg-v1
#oc get secrets -l=app=react-fatesg
#oc delete template/react-web-app -n fatesg-v1

NAMESPACE='fatesg-v1'
APPLICATION_NAME='react-fatesg'
SOURCE_REPOSITORY_URL='https://github.com/lholmquist/react-web-app'

#Projeto React
#https://github.com/lholmquist/react-web-app
#-p OUTPUT_DIR=build

#Projeto Angular
#https://github.com/brunourb/openshift-angular-app
#-p OUTPUT_DIR=dist/${APPLICATION_NAME}

#Base64 encoding is not an encryption method and is considered the same as plain text.
#https://kubernetes.io/docs/concepts/configuration/secret/
GITHUB_WEBHOOK_SECRET=$(echo -ne '123456789' | base64)
#GITLAB_USER='fatesg'
#GITLAB_PASSWORD=$(echo -n 'gitlab2021' | base64)

#https://docs.openshift.com/container-platform/4.5/support/troubleshooting/diagnosing-oc-issues.html
oc new-app -n $NAMESPACE \
           -p APPLICATION_NAME=$APPLICATION_NAME \
           -p SOURCE_REPOSITORY_URL=$SOURCE_REPOSITORY_URL \
           -p GITHUB_WEBHOOK_SECRET=$GITHUB_WEBHOOK_SECRET \
           -p SOURCE_REPOSITORY_REF=main \
           -p OUTPUT_DIR=build \
            fatesg-react
# --loglevel
#!/bin/bash


# Uncomment the following line and specify your master:port to log into if you want to automate the login and not have to login prior to running this script
# oc login https://192.168.122.124:8443 --insecure-skip-tls-verify -u openshift-dev -p devel
oc new-project app-dev --display-name="Application Development Environment"
oc new-app --name=bluegreen https://github.com/bit4man/bluegreen#ocp33-pipeline
oc expose service bluegreen
oc new-app jenkins-ephemeral -p JENKINS_PASSWORD=password
oc create -f https://raw.githubusercontent.com/bit4man/bluegreen/ocp33-pipeline/php-bluegreen-app-pipeline-bc.yml
oc new-project app-qa --display-name="Application QA Environment"
oc new-project app-prod --display-name="Application Production Environment"

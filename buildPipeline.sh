#!/bin/bash
set -euox pipefail

apikey=`cat .apikey`
pipeline=`cat Jenkinsfile|tr -d "\n"|sed 's/\"/\\\"/g'`
master_url="infrastructure.ci.prezi.com"
jobname="juli-test-pipeline"

curl -X POST -u "${apikey}" https://$master_url/job/$jobname/lastBuild/replay/run --data-urlencode "json={\"mainScript\":\"$pipeline\"}" --data-urlencode 'Submit=Run'

#!/bin/bash
set -euo pipefail

apikey=`cat .apikey`
pipeline=`cat Jenkinsfile|sed -e 's/\([^\{\}]\)$/\1;/'|tr -d "\n"|sed 's/\"/\\\"/g'`
master_url="infrastructure.ci.prezi.com"

jobname="Jenkinsfile-tester"

curl -X POST -u "${apikey}" https://$master_url/job/$jobname/lastBuild/replay/run --data-urlencode "json={\"mainScript\":\"$pipeline\"}" --data-urlencode 'Submit=Run'

open "https://$master_url/job/$jobname/lastBuild/console"

#!/bin/bash
set -euo pipefail

#get params
while IFS= read -r var
do
    export "$var"
done < repo_conf


apikey=`cat $apikey_file`
pipeline=`cat Jenkinsfile|sed -e 's/\([^\{\}]\)$/\1;/'|tr -d "\n"|sed 's/\"/\\\"/g'`


curl -X POST -u "${apikey}" https://$master_url/job/$jobname/lastBuild/replay/run --data-urlencode "json={\"mainScript\":\"$pipeline\"}" --data-urlencode 'Submit=Run'

open "https://$master_url/job/$jobname/lastBuild/console"
 

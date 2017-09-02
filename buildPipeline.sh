#!/bin/bash
set -euo pipefail

#get params
while IFS= read -r var
do
    export "$var"
done < repo_conf


pipeline_file="Jenkinsfile"

if [ $# == 1 ]; then
    pipeline_file=$1
    shift
fi

if [ ! -f $pipeline_file ]; then
    echo "No file found: $pipeline_file"
    exit -1
fi

apikey=`cat $apikey_file`
pipeline=`cat $pipeline_file|sed -e 's/\([^\{\}]\)$/\1;/'|tr -d "\n"|sed 's/\"/\\\"/g'`

ret=`curl -X POST -u "${apikey}" -si "https://$master_url/job/$jobname/lastBuild/replay/run" --data-urlencode "json={\"mainScript\":\"$pipeline\"}" --data-urlencode 'Submit=Run'`

OK=`echo $ret|grep HTTP|grep 302`
if [ "$OK" != "" ]; then
open "https://$master_url/job/$jobname/lastBuild/console"
fi

# pipeline-test

Script to run the Jenkinsfile in the repo as a replay pipeline job. 

Expects to have access credentials in a file called .apikey in the format of "username:apikey".

####
Potential improvement: it shouldnt need to be tied to a specific build. If we had an API where we can just submit a pipeline code and a repo to work with. 

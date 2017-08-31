# pipeline-test

Script to run the Jenkinsfile in the repo as a replay pipeline job. 

## setup
- Create a Pipeline job on your master that has no SCM assosiation. It can be empty.
- Edit the buildPipeline script to have the name of your master and your job. 
- get your API jey for jenkins and pit it into a file called .apikey as "username:apikey"
## usage

```$./bui.dPipeline.sh```

####
Potential improvement: it shouldnt need to be tied to a specific build. If we had an API where we can just submit a pipeline code and a repo to work with. 

# pipeline-test

Script to run the Jenkinsfile in the repo as a replay pipeline job. 

## What is the problem I am trying to solve?
Jenkinsfiles is awesome, because you can store your jenkins job as code, together with your repo. You can do version control, codereviews, reverts. [Unittests even.](https://event.crowdcompass.com/jenkinsworld2017/activity/pZh3gWomGZ). What you cannot do, is develop this code as you usually would: edit, see if it runs, run local tests, repeat. For developing Jenkinsfiles, you have two options currently:
- create a Pipeline job that has the code in the config, and edit it there, in the online editor
- push every change you make to SCM and have it picked up there. 

(Or, if you are adventurous, you can try [running a jenkins master locally and run pipeline there](https://event.crowdcompass.com/jenkinsworld2017/activity/RkAzPhl5FD), but for me that has a bad smell.)

The bottleneck here seems to be the running of the job. Could you run it without committing it or editing it online? With this little script, you can. The buildPipeline.sh here loos for a Jenkinsfile next to it, and sends request to the jenkins master to run it as is. 

### yes but which repo? 

Right now, scm steps are only allowed in job types that has an SCM repo associated with them (multibranch pipeline jobs or Jenkinsfile from SCM jobs), we need a jenkins job of that type. There is a setup script that sets it up on a master, or you can set it up for yourself. 

A Jenkinsfile is considered something as being closely tied to your code (and therefore only developed with it), but actually in many cases it may not be true. There can be usecases where the Pipeline script is relatively unrelated from the actual SCM repo, and it is rather just a parameter for it (eg if your services are created from a template, and they could all use the same Jenkinsfile). The information about the SCM repo is actually in the jenkins job, not in the Jenkinsfile. So why not develop the Jenkinsfile in normal iterations, where the repo may or may not be important? It could be just a parameter? TODO: open issue about it. 

## setup

1. Fill out the repo\_conf file with the information about the master and job. If you already have the job created, set 'jobname' to the name. The 'repo\_url' should be the full https url of the repo with which you want your Jenkinsfile to be associated with. The repo\_creds_name is the name of the credentials that gives access to this url (it should be saved in your Jenkins master). Get your API jey for jenkins and pit it into a file called .apikey. 
2. run 'setup.sh' which will create the job for you if it is missing, or update it with the right repo if it isnt. 

## usage

Run 
```$./buildPipeline.sh```

 

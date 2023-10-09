ARG ALPINE_VERSION=3.18.0
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache zip tini aws-cli curl coreutils postgresql15-client

#=========POSTGRES========#
#Make sure that your shell script file is in the same folder as your dockerfile while running the docker build command as the below command will copy the file to the /home/root/ folder for execution. 
COPY ./do-backup.sh /home/root/ 
#Copying script file
USER root 
#switching the user to give elevated access to the commands being executed from the k8s cron job

#file-name: dockerfile
FROM ubuntu:18.04

# Run the Update
RUN apt-get update && apt-get upgrade -y

# download and install pip
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update 
RUN apt-get install python3.11
RUN python -m ensurepip --upgrade

# install AWS CLI
RUN pip install awscli

#=========POSTGRES========#
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y postgresql-client curl

#Make sure that your shell script file is in the same folder as your dockerfile while running the docker build command as the below command will copy the file to the /home/root/ folder for execution. 
COPY ./do-backup.sh /home/root/ 
#Copying script file
USER root 
#switching the user to give elevated access to the commands being executed from the k8s cron job

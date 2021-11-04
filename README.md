# Postgres Backup Container

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/sethpyle376/postgres-backup-job/Build%20and%20Publish)
![Docker Pulls](https://img.shields.io/docker/pulls/sethpyle/pg-backup)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/sethpyle/pg-backup)


This is a simple container designed to dump a Postgres DB and back it up to S3. Additionally it can send alerts to a Discord channel to notify of job success/failure. 
This was built with the intention of being used as a Kubernetes cron job.

x86 and ARM64 images are available.

## Environment Variables
- PG_HOST - Postgres Host Name
- PG_PORT - Postgres Port
- PG_USER - Postgres Username (Needs to be a super user with permissions to all tables/data)
- PG_PASS - Postgres Password
- DISCORD_WEBHOOK - Webhook to post job notifications to.
- AWS_ACCESS_KEY_ID - Key to AWS account used for S3
- AWS_SECRET_ACCESS_KEY - Secret key to AWS account used for S3
- AWS_DEFAULT_REGION - AWS region S3 bucket resides in.
- S3_BUCKET - S3 URL to bucket the backup is being pushed to.

#file-name: postgres-backup.sh
#!/bin/bash

cd /home/root
mkdir pg-backup
date1=$(date +%Y%m%d-%H%M)
PGPASSWORD="$PG_PASS" pg_dumpall -h $PG_HOST -p $PG_PORT -U $PG_USER > pg-backup/postgres-db.sql
file_name="pg-backup-"$date1".tar.gz"

#Compressing backup file for upload
tar -zcvf $file_name pg-backup

notification_msg="Postgres backup failed."
filesize=$(stat -c %s $file_name)
mfs=10

if [[ "$filesize" -gt "$mfs" ]]; then
pretty_filesize=$(echo $filesize | numfmt --to=iec-i)

#Uploading to s3
aws s3 cp pg-backup-$date1.tar.gz $S3_BUCKET

notification_msg="Postgres backup successful, compressed filesize was $pretty_filesize"
fi

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"$notification_msg\"}" $DISCORD_WEBHOOK

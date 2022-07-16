#file-name: postgres-backup.sh
#!/bin/bash

cd /home/root
mkdir pg-backup
PGPASSWORD="$PG_PASS" pg_dumpall -h $PG_HOST -p $PG_PORT -U $PG_USER > pg-backup/postgres-db.sql
file_name="pg-backup.tar.gz"

#Compressing backup file for upload
tar -zcvf $file_name pg-backup

notification_msg="Postgres backup failed."
filesize=$(stat -c %s $file_name)
mfs=10
if [[ "$filesize" -gt "$mfs" ]]; then
pretty_filesize=$(echo $filesize | numfmt --to=iec-i)
cp $file_name /backup
notification_msg="Postgres backup successful, compressed filesize was $pretty_filesize"
fi

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"$notification_msg\"}" $DISCORD_WEBHOOK

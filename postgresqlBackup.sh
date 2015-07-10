#!/bin/bash
# Script que realiza una copia de seguridad de las BBDD de PostgreSQL.
# Directorio para almacenar los backups.
backup_dir="/var/backups/postgresql/"
# Fecha del backup para el fichero.
backup_date=`date +%d-%m-%Y`
# Numero de dias a almacenar los backups antiguos.
number_of_days=30
databases=`sudo -u postgres psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`
# Copia de seguridad de cada BD de PostgreSQL.
for i in $databases; do
  if [ "$i" != "template0" ] && [ "$i" != "template1" ]; then
    echo Dumping $i to $backup_dir$i\_$backup_date
    sudo -u postgres pg_dump -Fc $i|gzip > $backup_dir$i\_$backup_date.gz
  fi
done
# Borrado de backups antiguos que superen el límite de días.
find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;
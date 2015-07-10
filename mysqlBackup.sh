#!/bin/sh
# Script que realiza una copia de seguridad de una BD de MySQL.
# El script borra backups antiguos y almacena como logs todas sus acciones.
# Se deben de modificar los argumentos de la línea 13 para adaptarlos a la BD actual.
now="$(date +'%d_%m_%Y_%H_%M_%S')"
# Nombre del fichero de backup.
filename="db_backup_$now".gz
backupfolder="/home/Piraces/Backups"
fullpathbackupfile="$backupfolder/$filename"
logfile="$backupfolder/"backup_log_"$(date +'%Y_%m')".txt
echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
# Comando mysqldump (realiza el backup).
mysqldump --user=mydbuser --password=mypass --default-character-set=utf8 mydatabase | gzip > "$fullpathbackupfile"
echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
# Ajuste de permisos para el backup.
chown myuser "$fullpathbackupfile"
chown myuser "$logfile"
echo "file permission changed" >> "$logfile"
# Borrado de ficheros de backups antiguos.
find "$backupfolder" -name db_backup_* -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$logfile"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
echo "*****************" >> "$logfile"
exit 0
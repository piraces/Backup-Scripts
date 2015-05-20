# Necesita la contraseña de MySQL para exportar la BD correspondiente.
# Añadir a cron para ejecutar automaticamente cada cierto tiempo.

dirGuardado="/root/Backups/WIKI"
fecha=$(date +%y-%m-%d_%H:%M:%S)
mkdir ${dirGuardado}/${fecha}
echo "Starting MediaWiki backup..."
echo "Dumping MySQL database..."
mysqldump -u <USER HERE> -p<PASS HERE> wiki > dumpWiki.sql
echo "[OK] Dump MySQL database correct"
echo "Dumping complete Wiki..."
tar -zcvf backupWiki.tar.gz /var/www/html
echo "[OK] Dumping directories correct"
echo [OK] All files copied. Compressing...
        tar -czvf ${dirGuardado}/wiki_${fecha}.tar.gz ${dirGuardado}/${fecha}/ #Comprimimos archivos
        rm -rf ${dirGuardado}/${fecha} #Borramos directorio
	rm -rf dumpWiki.sql
	rm -rf backupWiki.tar.gz
	echo [OK] Copy finished.

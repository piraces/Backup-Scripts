# Necesita las llaves de ssh de central del usuario para funcionar correctamente.
# Añadir a cron para ejecutar automaticamente cada cierto tiempo.
dirOrigen="/misc/alumnos/as2/as22014/a490790"
dirGuardado="/home/piraces/Backup/ASIS2"
base="o.qcow2"
base2="u.qcow2"
var=$(ssh a490790@central.cps.unizar.es ls  /misc/alumnos/as2/as22014/a490790)
fecha=$(date +%y-%m-%d_%H:%M:%S)
mkdir ${dirGuardado}/${fecha}
echo "Iniciando backup de asis2..."
for f in $var
do
        if [ $f != $base ] && [ $f != $base2 ]
        then
                rsync -a a490790@central.cps.unizar.es:${dirOrigen}/${f} ${dirGuardado}/${fecha}/
                echo [OK] Backup correcto de fichero ${f}
        fi

done
echo [OK] Todos los archivos copiados. Comprimiendo...
        tar -czvf ${dirGuardado}/asis2_${fecha}.tar.gz ${dirGuardado}/${fecha}/ #Comprimimos archivos
        rm -rf ${dirGuardado}/${fecha} #Borramos directorio
        echo [OK] Copia realizada.

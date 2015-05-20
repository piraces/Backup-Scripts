# Añadir a cron para ejecutar automaticamente cada cierto tiempo.
dirGuardado="/home/example/GIT"
repo="https://github.com/piraces/Wallapet.git"
repo2="https://github.com/piraces/Wallapet-Server.git"
fecha=$(date +%y-%m-%d_%H:%M:%S)
mkdir ${dirGuardado}/${fecha}
echo "Iniciando backup de github..."

git clone ${repo} ${dirGuardado}/${fecha}

echo [OK] Todos los archivos copiados. Comprimiendo...
        tar -czvf ${dirGuardado}/PS_${fecha}.tar.gz ${dirGuardado}/${fecha}/ #Comprimimos archivos
        rm -rf ${dirGuardado}/${fecha} #Borramos directorio
        echo [OK] Copia realizada.

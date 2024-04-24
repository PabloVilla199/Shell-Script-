#!/bin/bash

Guid="$1"

ComprobarParametros() {
    if [ $# -ne 1 ]; then 
        echo "Número de parámetros incorrecto"
        exit 1
    fi
}

BuscarGuid() {
    fila_usuarios=$(grep "$Guid" /etc/passwd)
    for usuario in $fila_usuarios; do
        nombre_usuario=$(echo $usuario | cut -d: -f1)
        echo "Usuario: $nombre_usuario"
        archivos_usuario=$(echo $usuario | cut -d: -f6)
        echo "Archivos del Usuario: "
        find "$archivos_usuario" -user $Guid
        echo "Los archivos del usuario ocupan: "
        du -sh $archivos_usuario 
    done
}

ComprobarParametros "$Guid"
BuscarGuid "$Guid"

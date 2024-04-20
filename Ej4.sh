#!/bin/bash

directorio="/var/log"
directorio_copia="/home/pablovilla/Desktop "

procesar_archivo_log() {

    local archivo_log="$1"
    local num_lineas=$(wc -l < "$archivo_log")
    
    echo $num_lineas

    if [ "$num_lineas" -gt 1000 ]; then
        guardar_copia_seguridad "$archivo_log"
    else
        echo "El archivo $archivo_log no cumple con los requisitos."
    fi
}


guardar_copia_seguridad() {
    local archivo_log="$1"

    tail -n 500 "$archivo_log" > "$archivo_log1".

    gzip "$archivo_log1"

    mv "$archivo_log1".gz "$directorio_copia"



    echo "El archivo $archivo_log ha sido procesado y guardado en $directorio_copia."
}

for archivo_log in "$directorio"/*.log; do
    procesar_archivo_log "$archivo_log"
done

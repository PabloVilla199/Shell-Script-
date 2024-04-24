#!/bin/bash

Ficheros_existentes(){
    ficheros=$(find ./ -type f)
}

Eliminar_Ficheros_vacios(){
    for fichero in $ficheros; do
       if [ ! -s "$fichero" ]; then
          rm "$fichero"
          echo "Fichero vacío eliminado: $fichero"
       fi
    done
}


Ficheros_existentes 
Eliminar_ficheros_vacios

if [ $? -eq 0 ]; then
    echo "Ficheros vacíos eliminados correctamente."
else
    echo "No se encontraron ficheros vacíos para eliminar."
fi

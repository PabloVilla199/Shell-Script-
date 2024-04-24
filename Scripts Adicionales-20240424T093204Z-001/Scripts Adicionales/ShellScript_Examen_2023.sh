#!/bin/bash

find ./ -type f -empty  -delete

# Verificar si se eliminaron ficheros vacíos
if [ $? -eq 0 ]; then
    echo "Ficheros vacíos eliminados correctamente."
else
    echo "No se encontraron ficheros vacíos para eliminar."
fi

 

#!/bin/bash

# Obtener la lista de ficheros en el directorio actual y sus subdirectorios
ficheros=$(find ./ -type f)

# Recorrer la lista de ficheros
for fichero in $ficheros; do
    # Verificar si el fichero está vacío
    if [ ! -s "$fichero" ]; then
        # Eliminar el fichero si está vacío
        rm "$fichero"
        echo "Fichero vacío eliminado: $fichero"
    fi
done

# Verificar si se eliminaron ficheros vacíos
if [ $? -eq 0 ]; then
    echo "Ficheros vacíos eliminados correctamente."
else
    echo "No se encontraron ficheros vacíos para eliminar."
fi

    
   
 
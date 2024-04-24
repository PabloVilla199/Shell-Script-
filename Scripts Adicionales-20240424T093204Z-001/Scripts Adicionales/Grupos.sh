#!/bin/bash

# Verificar si se proporciona un nombre de grupo como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 <nombre_de_grupo>"
    exit 1
fi

# Nombre del grupo a buscar
group_name=$1

# Verificar si el grupo existe en /etc/group
if grep -q "^$group_name:" /etc/group; then
    echo "El grupo $group_name es válido."

    # Ejecutar el comando para mostrar información sobre el grupo
    grep "^$group_name:" /etc/group
else
    echo "El grupo $group_name no es válido."
fi









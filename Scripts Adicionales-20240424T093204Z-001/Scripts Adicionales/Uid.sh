#!/bin/bash

ValidarParametros() {
    if [ $# -ne 1 ]; then
        echo "Número de argumentos incorrecto"
        exit 1
    fi
}

obtenerUsuario() {
    filaUsuario=$(grep $1 /etc/passwd)
    if [ -z "$filaUsuario" ]; then
        echo "Usuario no encontrado."
        exit 2
    fi

    usuario=$(echo "$filaUsuario" | cut -d: -f1)
    gid=$(echo "$filaUsuario" | cut -d: -f3)
    directorio=$(echo "$filaUsuario" | cut -d: -f6)
    shell=$(echo "$filaUsuario" | cut -d: -f7)

    echo "El usuario es: $usuario"
    echo "GID: $gid"
    echo "Directorio: $directorio"
    echo "Shell: $shell"
}
obtenerGrupos(){
grupos= $(grep $usuario /etc/group | cut -d: -f3)

echo "Los grupos secundarios del gid son " grupos 

}

CreardDirectorioPersonal() {
    if [ -d "$directorio" ]; then
        echo "El directorio personal ya existe."
    else
        mkdir "$directorio"
        echo "Se ha creado un directorio personal para el usuario"
    fi
}

AsignarShell() {
    if [ -n "$shell" ]; then
        echo "La shell ya está asignada al usuario."
    else
        Shellsdisponibles=$(cat /etc/shells)
        for shell in $Shellsdisponibles; do
            if [ $shell -ne "/sbin/nologin" ]; then
                chsh -s "$shell" "$1"
                echo "Shell asignada al usuario"
                break
            fi
        done
    fi
}

MostrarInformacionUsuario() {
    finger "$usuario"
}

VerificarContrasena () {
    contrasena=$(grep "^$usuario:" /etc/shadow | cut -d: -f2)
    if [ "$contrasena" -ne "*" ] && [ "$contrasena" -ne "!" ]; then
        echo "La contraseña está activa: " $contrasena
    else
        echo "La contraseña no está activa." $contrasena
    fi
}


ValidarParametros "$@"

obtenerUsuario "$1"

CreardDirectorioPersonal

AsignarShell "$1"
echo 
MostrarInformacionUsuario

VerificarContrasena

#!/bin/bash

ValidarParametros(){
    if [ "$#" -ne 3 ]; then
      echo "Número de parámetros incorrecto"
      exit 1
    fi
}

login="$1"
nombre_real="$2"
grupo="$3"

ValidarLogin() {
   if ! [[ "$login" =~ ^[a-z]+$ || ${#login} -lt 3 || ${#login} -gt 8 ]]; then
      echo "Login incorrecto: el login debe tener entre 3 y 8 caracteres y estar en minúsculas."
      exit 1
   fi
}

Validarnombre(){
    if [[ "$nombre_real" == *":"* ]]; then
      echo "El nombre real no puede contener el carácter (:)"
      exit 1
    fi
}

ValidarGrupo(){
    if [ "$grupo" != "contabilidad" ] && [ "$grupo" != "finanzas" ] && [ "$grupo" != "estadistica" ]; then
       echo "Grupo incorrecto: el grupo tiene que ser contabilidad, finanzas, o estadística"
       exit 1
    fi
}

buscarGrupo(){
     gid=$(grep "^$grupo:" /etc/group | cut -d ':' -f 3)
}

CrearGid(){
 if [ -z "$gid" ]; then
    echo "El grupo no tiene gid"
    echo "Se creará un gid entre 100-999" 
    
    for i in {100..999}; do 
           grep ":$i:" /etc/group
           if [ $? -ne 0 ]; then
              gid="$i"
              break
          fi 
    done 
 fi
}

ComprobarGid(){
    if [ -z "$gid" ]; then
       echo "Error al obtener el GID del grupo $grupo"
       exit 1
   fi
}

CrearUsuario(){
    sudo useradd -m -d "/home/$nombre_real" -g "$grupo" -s /bin/bash "$login" 
    if [ $? -ne 0 ]; then
        echo "Error al crear el usuario"
        exit 1
    fi
}

Cambiarcontrasena(){
   intentos=0
   while [ "$intentos" -lt 3 ]; do
         echo "Por favor, introduzca la contraseña para el usuario $login:"
         sudo passwd "$login"
         if [ $? -eq 0 ]; then
            echo "Contraseña actualizada"
            break
         else
           intentos=$((intentos+1))
           echo "Error al cambiar la contraseña. Intento $intentos de 3."
         fi
   done

   if [ "$intentos" -eq 3 ]; then
     echo "Se ha excedido el número de intentos permitidos. La cuenta de usuario se bloqueará."
     sudo passwd -l "$login"
     exit 1
  else
    echo "El usuario $login ha sido creado correctamente"
    
    fi
}

# Validaciones
ValidarParametros "$@"
ValidarLogin
Validarnombre
ValidarGrupo
buscarGrupo
CrearGid
ComprobarGid
CrearUsuario
Cambiarcontrasena

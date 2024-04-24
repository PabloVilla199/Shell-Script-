#!/bin/bash


validarNumParametros(){
	if [ $# -eq 0 ]; then
    	   echo "Error: Debes proporcionar un parámetro."
           listar_usuarios_borrados
           exit 1
        fi
}

validarParametroNumerico(){
   if [ ! $1 -eq ^[0-9]+$ ]; then
      echo "Error: El parámetro debe ser un número."
      exit 1
   fi
}

listarUsuariosInactivos(){
    find /var/mail -type f ! -atime -"$1" -exec basename {} \;
}

mostrar_usuarios_eliminados(){
   usuarios_eliminados=$(find /var/mail -type f -exec test -d /home/{} \; -printf "%f\n")

   if [[ $usuarios_eliminados != ""]]
   then
      echo "Usuarios eliminados pero con archivos de correo:"
      echo "$usuarios_eliminados"
      echo -e "\n"
   else
      echo "No hay usuarios eliminados"
      fi
}

validarNumParametros $#
validarParametroNumerico $1
listarUsuariosInactivos $#
mostrar_usuarios_inactivos $#

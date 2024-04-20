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
    if [ $# -eq 1 ]; then
       listar_usuarios_inactivos "$1"
     fi
}

validarNumParametros $#
validarParametroNumerico $1
listarUsuariosInactivos $#

#!/bin/bash

mostrarMenu(){

  echo "Manipulacion de Ficheros tar"
  echo " a) Generar fichero tar"
  echo " b) Extraer fichero tar"
  echo " c) Dar informacion relativa a un tar"
  echo " d) Listar fichero de un tar "

  read -p "Elige una opción: " opcion
  darOpcion "$opcion"
}

darOpcion(){

  case $1 in
     "a")  generarFicheroTar  ;;
     
     "b")  extraerFicheroTar  ;;
     
     "c")  darInformacionFichero  ;;
     
     "d")  MostrarListadoFicheros   ;;
     
       *)  echo "Error Opcion no valida"
   esac  
}

generarFicheroTar(){

  read -p "Introduce el nombre del fichero o directorio que deseas comprimir: " fichero
  tar -cvf "$fichero.tar" "$fichero"
}

extraerFicheroTar(){

  read -p "Introduce el nombre del archivo tar que deseas extraer: " archivo_tar
  tar -xvf "$archivo_tar"
}

darInformacionFichero(){

  read -p "Introduce el nombre del archivo tar del que deseas ver la información: " archivo_tar
  tar -tvf "$archivo_tar"
}

MostrarListadoFicheros(){

  read -p "Introduce el nombre del archivo tar del que deseas listar los archivos: " archivo_tar
  tar -tf "$archivo_tar"
}

mostrarMenu

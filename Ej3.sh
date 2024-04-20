#!/bin/bash

verificarNumArgumentos(){
  if [ $# -ne 1 ]; then 
    echo "Número de argumentos incorrecto"
    exit 1
  fi
}

validarDirectorio(){
  if [ ! -d "$1" ]; then 
    echo "$1 no es un directorio"
    exit 1
  fi
}

analizarDirectorio(){
    local directorio="$1"
    local ficheros=$(find "$directorio" -type f | wc -l)
    local directorios=$(find "$directorio" -type d | wc -l)
    local enlaces=$(find "$directorio" -type l | wc -l)
    local dispositivos_bloque=$(find "$directorio" -type b | wc -l)
    local dispositivos_caracter=$(find "$directorio" -type c | wc -l)
    local pipes=$(find "$directorio" -type p | wc -l)
    local sockets=$(find "$directorio" -type s | wc -l)
    
    local total=$((ficheros + directorios + enlaces + dispositivos_bloque + dispositivos_caracter + pipes + sockets))
    
    echo "Análisis de $directorio"
    echo "$total archivos encontrados:"
    echo "* $ficheros archivos normales ($ficheros/ $total) %"
    echo "* $directorios directorios"
    echo "* $dispositivos_bloque dispositivos de bloque" 
    echo "* $dispositivos_caracter dispositivos de caracteres"
    echo "* $pipes pipes"
    echo "* $sockets sockets"
    echo "* $enlaces enlaces simbólicos"
}

verificarNumArgumentos "$@"
validarDirectorio "$1"
analizarDirectorio "$1"

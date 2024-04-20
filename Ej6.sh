#!/bin/bash

read -p "Introduce una palabra: " palabra 
read -p "Introduce la longitud de la palabra: " longitud

ValidarLongitud(){
   if [ ${#palabra} -ne $longitud ]; then
     echo "La longitud de las palabras no coincide"
     exit 1
   fi
}

calcularVocales(){
    numVocales=$(echo $palabra | grep -io '[AEIOU]' | wc -l)
    numConsonantes=$(( ${#palabra} - $numVocales ))
    
    echo "Numero de vocales " $numVocales 
    echo "Numero de consonantes " $numConsonantes
}

VocalesIguales(){
    if [ $numVocales -ne $numConsonantes ]; then
        echo "El número de vocales y consonantes no es el mismo"
    else
        echo "El número de vocales y consonantes es el mismo"
    fi
}

ValidarLongitud
calcularVocales
VocalesIguales

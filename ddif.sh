#!/bin/bash 

inverso=false 

validarNumArgumentos() {
   if [ $# -lt 1 ]; then 
      echo "Numero de argumentos incorrecto"
      exit 1 
   fi
}

hayInverso(){
    if [ "$1" = "-r" ]; then 
      inverso=true 
    fi
}

hayDosDirectorios(){
  if [ $# -eq 3 ]; then
     dir1="$2"
     dir2="$3"
     
  elif [ $# -eq 2 ] && [ "$inverso" = true ]; then 
     dir1="$2"
     dir2=$(ls -l)
     
  elif [ $# -eq 2 ] && [ "$inverso" = false ]; then 
     dir1="$1"
     dir2="$2"
  else
    dir1="$1"  
    dir2=$(ls -l)
 fi

}

directoriosValidos(){

  if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then 
     echo "Error Directorios no validos "
     exit 1 
  fi 
}

mostrar_diferencias(){ 


  fich1=$(find "$dir1" -type f)
  fich2=$(find "$dir2" -type f)
  

  ficherosDiferentes=$(echo "$fich1 $fich2" | sort -u)

  if [ -n "$ficherosDiferentes" ]; then
    echo "Ficheros diferentes entre $dir1 y $dir2:"
    echo "$ficherosDiferentes"
  else
    echo "No hay ficheros comunes entre los directorios."
  fi
}



mostrar_ficheros_Comunes(){ 

  fich1=$(find "$dir1" -type f)
  fich2=$(find "$dir2" -type f)
  

  ficherosComunes=$(echo "$fich1 $fich2" | sort | uniq -d)

  if [ -n "$ficherosComunes" ]; then
    echo "Ficheros comunes entre $dir1 y $dir2:"
    echo "$ficherosComunes"
  else
    echo "No hay ficheros comunes entre los directorios."
  fi
}



validarNumArgumentos "$@"

hayInverso "$@"

hayDosDirectorios "$@"

directoriosValidos "$dir1" "$dir2"

if [ "$inverso" = true ]; then
  mostrar_ficheros_Comunes "$dir1" "$dir2"
else
  mostrar_diferencias "$dir1" "$dir2"
fi

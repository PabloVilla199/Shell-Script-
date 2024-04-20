#!/bin/bash

validarNumeroDeArgumentos(){ 
  if [ $# -ne 1 ]; then 
      echo "Número de argumentos no válido"
      exit 1
  fi
}

validarNumCaracteres(){
  if [ ${#1} -ne 9 ]; then 
     echo "El argumento no tiene 9 caracteres"
     exit 1
  fi
}

descifrarPermisos(){
  permisos=$1
  local decimal=""
  
  for (( i=0; i<${#permisos}; i+=3 )); do
    grupo="${permisos:$i:3}"
    case "$grupo" in
      "---") decimal+="0" ;;
      "--s") decimal+="44" ;;
      "--t") decimal+="4" ;;
      "--x") decimal+="1" ;;
      "-w-") decimal+="2" ;;
      "-ws") decimal+="46" ;;
      "-wt") decimal+="6" ;;
      "-wx") decimal+="3" ;;
      "r--") decimal+="4" ;;
      "r-s") decimal+="45" ;;
      "r-t") decimal+="5" ;;
      "r-x") decimal+="5" ;;
      "rw-") decimal+="6" ;;
      "rws") decimal+="47" ;;
      "rwt") decimal+="7" ;;
      "rwx") decimal+="7" ;;
      *) echo "Permisos inválidos: $grupo"; exit 1 ;;
    esac
  done
  echo "$decimal"
}

validarNumeroDeArgumentos "$@"

validarNumCaracteres "$1"

descifrarPermisos "$1"

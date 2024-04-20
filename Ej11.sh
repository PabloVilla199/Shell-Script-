#!/bin/bash 


vector="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
contrasena=""
GenerarContrasena(){
   for i in {1..10}; do
     index=$((RANDOM % ${#vector}))
     contrasena="${contrasena}${vector:index:1}"
  done
 echo "Contraseña generada: $contrasena"
}

ComprimirContrasena(){
  contrasena_comprimida=""
  caracter_actual="${contrasena:0:1}"
  contador=1
  for ((i = 1; i < ${#contrasena}; i++)); do
      if [[ "${contrasena:i:1}" == "$caracter_actual" ]]; then
          contador=$((contador + 1))
     else
         if [[ $contador -eq 1 ]]; then
            contrasena_comprimida="${contrasena_comprimida}${caracter_actual}"
        else
            contrasena_comprimida="${contrasena_comprimida}${contador}${caracter_actual}"
        fi
           caracter_actual="${contrasena:i:1}"
           contador=1
        fi
   done
   
   if [[ $contador -eq 1 ]]; then
      contrasena_comprimida="${contrasena_comprimida}${caracter_actual}"
   else
    contrasena_comprimida="${contrasena_comprimida}${contador}${caracter_actual}"
  fi
  echo "Contraseña comprimida: $contrasena_comprimida"

}
CifrarContrasena(){
    typeset -a contrasena_cifrada
    constante=42
    echo -n "Contraseña cifrada: "
    for ((i = 0; i < ${#contrasena_comprimida}; i++)); do
        caracter="${contrasena_comprimida:i:1}"
        codigo_ascii=$(printf "%d" "'$caracter")
        cifrado=$(( (codigo_ascii + constante) % 256 ))
        contrasena_cifrada[$i]=$cifrado
        echo -n "$cifrado "
    done
    echo  
}


GenerarContrasena
ComprimirContrasena
CifrarContrasena


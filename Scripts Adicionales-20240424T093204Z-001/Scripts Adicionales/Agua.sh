#!/bin/bash


typeset -a consumo_agua
typeset -a consumo_trimestral


consumo_agua=("$@")


ComprobarParametros() {
  if [ ${#consumo_agua[@]} -ne 12 ]; then
    exit 1
  fi
}


Calculo_Consumo_medio() {
  for ((i = 0; i < 12; i++)); do
    indice=$((i / 3))
    consumo_trimestral[$indice]=$((${consumo_trimestral[$indice]} + ${consumo_agua[$i]}))
  done
  
  for ((i = 0;i < 4; i++)); do 
       consumo_trimestral[$i]=$(( ${consumo_trimestral[$i]}/3 ))
   done 
  local consumo_total=0
  for ((i = 0; i < 12; i++)); do
    consumo_total=$((consumo_total + ${consumo_agua[$i]}))
  done
  
  local consumo_medio=$((consumo_total / 12))
  echo "El consumo medio por trimestre es de $consumo_medio"
}


Calculo_Consumo_mayor() {
  local consumo_mayor=0
  local trimestre=0
  for ((i = 0; i < 4; i++)); do
    if [ $consumo_mayor -lt ${consumo_trimestral[$i]} ]; then
       consumo_mayor=${consumo_trimestral[$i]}
       trimestre=$((i + 1))
    fi
  done
  echo "El consumo mayor es de $consumo_mayor en el trimestre $trimestre"
}

Calculo_Consumo_menor() {
  local consumo_menor=${consumo_trimestral[0]}
  local trimestre=0
  for ((i = 1; i < 4; i++)); do
    if [ $consumo_menor -gt ${consumo_trimestral[$i]} ]; then
      consumo_menor=${consumo_trimestral[$i]}
      trimestre=$((i + 1))
    fi
  done
  echo "El consumo menor es de $consumo_menor en el trimestre $trimestre"
}

Mostrar_Consumo_mes(){
   echo "Consumo por mes: "
   for ((i = 0; i < 12; i++)); do
	   echo "Mes $((i + 1)): ${consumo_agua[$i]}"
   done 
}

Mostrar_Consumo_trimestre() {
  echo "Consumo por trimestre: "
  for ((i = 0; i < 4; i++)); do 
    echo "Trimestre $((i + 1)): ${consumo_trimestral[$i]}"
  done
}

ComprobarParametros
Calculo_Consumo_medio
Calculo_Consumo_mayor
Calculo_Consumo_menor
Mostrar_Consumo_mes
Mostrar_Consumo_trimestre

echo 

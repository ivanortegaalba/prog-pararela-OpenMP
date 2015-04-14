#!/bin/bash
# Autor: Ignacio Cordón Castillo
# Uso: gen_calc <nombre(s)_programa(s)>
# Descripción: 	Genera salida que se puede redirigir a un archivo .csv y crear
#               gráficos de tiempos en calc

FLAGS="-O2 -fopenmp -std=c99"
COMPILER=gcc
BIN=./bin

# Crea el directorio de los ejecutables si no existe
[ -d ${BIN} ] || mkdir ${BIN}

echo "Número de componentes, T. secuencial vect. Globales 1 thread/core, T. paralelo (versión for) 8 threads/cores, T. paralelo (versión sections) 8threads/cores"

for ((SIZE=2**14; SIZE<=2**26; SIZE*=2))
do
    line=`
        for PROGRAM_NAME in $@
        do
                [ -f ${PROGRAM_NAME} ] || continue
                PN=${PROGRAM_NAME##*/}
                # Le quitamos la extensión (.c,.cpp)
                PN=${PN%.*}
                [ -f ${BIN}/${PN} ] || $COMPILER $FLAGS ${PROGRAM_NAME} -o ${BIN}/${PN}
                ${BIN}/${PN} $SIZE | grep "Tiempo.\+" | cut -f1 -d / | grep -o "[[:digit:]]\+[.,][[:digit:]]\+"
        done | pr -10 -l 10 -s,`
        echo "$SIZE,$line"
done

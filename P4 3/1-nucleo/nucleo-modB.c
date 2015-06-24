/* (C) Programmed by:
   Antonio Jimenez Martínez


Practica 4 Arquitectura de Computadores
Version:0.1

EJERCICIO 1B

Para compilar: g++ -O2 estructura.c -lrt

*/
#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
//#define PRINTF_ALL



main()
{
    struct estructura {
        int a;
        int b;
    } s[5000];

    int  R[40000];
    double start, end, elapsed;
    int ii,i;
    int X1,X2;
    //inicializacion
    for(i=0; i<5000; i++) {
        s[i].a=2;
        s[i].b=3;
    }

    start = omp_get_wtime();

    for (ii=1; ii<=40000;ii++) {
        X1=0; X2=0;
        for(i=0; i<5000;i+=5)
            X1+=2*s[i].a+ii;
            X1+=2*s[i+1].a+ii;
            X1+=2*s[i+2].a+ii;
            X1+=2*s[i+3].a+ii;
            X1+=2*s[i+4].a+ii;
        for(i=0; i<5000;i+=5)
            X2+=3*s[i].b-ii;
            X2+=3*s[i+1].b-ii;
            X2+=3*s[i+2].b-ii;
            X2+=3*s[i+3].b-ii;
            X2+=3*s[i+4].b-ii;
        if (X1<X2)
            R[ii]=X1;
        else
            R[ii]=X2;
    }
    end = omp_get_wtime();
    elapsed = end - start;

    printf("Tiempo(seg.):%11.9f \n",elapsed);
#ifdef PRINTF_ALL
    for (ii=0; ii<=40000; ii++) {
        printf("%d ",R[ii]);
    }
    printf("\n");
#endif
}

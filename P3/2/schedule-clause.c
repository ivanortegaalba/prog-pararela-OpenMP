#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
  #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv)   {

   int i, n = 7,chunk, a[n],suma=0;

   if(argc < 2)     {
          fprintf(stderr,"\nFalta chunk \n");
          exit(-1);
     }
   chunk = atoi(argv[1]);

   for (i=0; i<n; i++)    a[i] = i;

   #pragma omp parallel for firstprivate(suma) \
                lastprivate(suma) schedule(static,chunk)
                // El schedule organiza la forma de repartir las iteraciones del bucle
                //Con static, establece un Round Robin, y departiendo de n en n, siendo n el chunck
                //Es similar a un reparto de cartas, se reparte por jugador tantas cartas como
                //determine el chunk.
   for (i=0; i<n; i++)
   {   suma = suma + a[i];
       printf(" thread %d suma a[%d] suma=%d \n",
             omp_get_thread_num(),i,suma);
   }

   printf("Fuera de 'parallel for' suma=%d\n",suma);

   return(0);
}

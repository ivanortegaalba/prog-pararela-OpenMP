#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
  #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv) {
   int i, n=20,chunk,a[n],suma=0;
   if(argc < 3)     {
      fprintf(stderr,"\nFalta iteraciones y/o chunk \n");
      exit(-1);
     }
   n = atoi(argv[1]); if (n>20) n=20; chunk = atoi(argv[2]);
   for (i=0; i<n; i++)      a[i] = i;

   #pragma omp parallel for firstprivate(suma) \
                 lastprivate(suma)  schedule(guided,chunk)
                 //Empezamos por el bloque más largo posible, hacemos una
                 //distribución previa igual que el static.
                 //Posteriormente, si una hebra queda esperando, se reasigna
                 //el trabajo restante previamente asignado a las otras hebras,
                 //y ahora si que se tiene en cuenta el chunk para reasignar.
   for (i=0; i<n; i++)
   {   suma = suma + a[i];
       printf(" thread %d suma a[%d]=%d suma=%d \n",
             omp_get_thread_num(),i,a[i],suma);
   }
   printf("Fuera de 'parallel for' suma=%d\n",suma);

   return(0);
}

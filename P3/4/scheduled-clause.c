#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
  #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv) {
  int i, n=200,chunk,a[n],suma=0;
  int primera = 1;
   if(argc < 3)     {
      fprintf(stderr,"\nFalta iteraciones o chunk \n");
      exit(-1);
     }
   n = atoi(argv[1]); if (n>200) n=200; chunk = atoi(argv[2]);

   for (i=0; i<n; i++)       a[i] = i;

   printf(" Fuera del parallel: \n");
   printf(" in-parallels> %s ;num-proc->%d; num-thread->%d; \n",
   omp_in_parallel(),omp_get_num_procs(),omp_get_num_threads());
   #pragma omp parallel for firstprivate(suma) \
            lastprivate(suma) schedule(guided,chunk)
   for (i=0; i<n; i++)
   {
       #pragma omp critical
       if (primera == 1){
           primera = 0;
           printf(" Dentro del parallel: \n");
           printf(" in-parallels-> %d ;num-proc->%d; num-thread->%d; \n",
               omp_in_parallel(),omp_get_num_procs(),omp_get_num_threads());
       }
        #pragma omp atomic
        suma = suma + a[i];
        #pragma omp critical
        printf(" thread %d suma a[%d]=%d suma=%d \n",
             omp_get_thread_num(),i,a[i],suma);
   }

   printf("Fuera de 'parallel for' suma=%d\n",suma);

   return(0);
}

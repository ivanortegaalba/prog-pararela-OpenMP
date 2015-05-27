#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
  #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv) {
  int i, n=200,chunk,a[n],suma=0;
  int dyn_var_value, nthreads_var_value, thread_limit_var;
  omp_sched_t kind;
  int modifier = 0;
  int primera = 1;

   if(argc < 3)     {
      fprintf(stderr,"\nFalta iteraciones o chunk \n");
      exit(-1);
     }
   n = atoi(argv[1]); if (n>200) n=200; chunk = atoi(argv[2]);

   for (i=0; i<n; i++)       a[i] = i;

   printf(" Antes de la modificación: \n");
   printf(" dyn-var-> %d ;nthreads-var->%d; thread-limit-var->%d; run-sched-var-kind->%d; run-sched-var-modifier->%d; \n",
   omp_get_dynamic(),omp_get_max_threads(),omp_get_thread_limit(), kind, modifier);

   //Modificación de las variables
   omp_set_num_threads(16);
   omp_set_schedule((omp_sched_t) 3,1);
   omp_set_dynamic(8);

   #pragma omp parallel for firstprivate(suma) \
            lastprivate(suma) schedule(static,chunk)
   for (i=0; i<n; i++)
   {
       #pragma omp critical
       if(primera == 1){
           primera = 0;
           omp_get_schedule(&kind, &modifier);
           printf(" Dentro del parallel: \n");
           printf(" dyn-var-> %d ;nthreads-var->%d; thread-limit-var->%d; run-sched-var-kind->%d; run-sched-var-modifier->%d; \n",
           omp_get_dynamic(),omp_get_max_threads(),omp_get_thread_limit(), kind, modifier);
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

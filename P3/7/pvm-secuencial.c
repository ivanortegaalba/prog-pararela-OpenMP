#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

main(int argc, char **argv) {
  int N = atoi(argv[1]);
  int i,j;
  omp_sched_t kind;
  int modifier;
  double **m, *v1, *v2;
  m = (double **)malloc (N*sizeof(double *));
  for (i=0;i<N;i++)
    m[i] = (double *) malloc (N*sizeof(double));

   v1 = (double *) malloc (N*sizeof(double));
   v2 = (double *) malloc (N*sizeof(double));

  double start,end,elapsed;
  if(argc < 2) {
  	fprintf(stderr,"Faltan argumentos\n");
  	exit(-1);
  }

  // Inicialización del vector y la matriz
    for (i = 0; i < N; ++i){
        v1[i] = i + 1;
        // Matriz triangular superior
        for(j = 0; j < i; ++j){
            m[i][j] = 0;
        }
        for(j = i; j < N; ++j){
            m[i][j] = j + 1;
        }
}
if(N<20){
    printf("Matriz:\n");
    for(i = 0; i < N;i++){
        for(j = 0; j < N; j++)
            printf(" %g ",m[i][j]);
            printf("\n");
    }
    printf("Vector:\n");
    for(i = 0; i < N;i++){
            printf(" %g ",v1[i]);
    }
    printf("\n");
}
    //Modificación de las variables
    omp_set_num_threads(omp_get_num_procs());
        omp_get_schedule(&kind, &modifier);
        //printf(" Dentro del parallel: \n");
        //printf(" dyn-var-> %d ;nthreads-var->%d; thread-limit-var->%d; run-sched-var-kind->%d; run-sched-var-modifier->%d; \n",
        //omp_get_dynamic(),omp_get_max_threads(),omp_get_thread_limit(), kind, modifier);
    start = omp_get_wtime();

  //Multiplicamos
  #pragma omp parallel for schedule(runtime) private (j)
  for (i=0; i<N; ++i){
      for (j=i; j<N; ++j)
      #pragma omp atomic
      v2[i] = (m[i][j] * v1[j])+v2[i];
  }

  end = omp_get_wtime();
  elapsed = end - start;
  //Imprimimos
  //printf("Vector Resultante:\n");
  if(N<20)
  for(i = 0; i < N;i++)
     printf("v[%d] = %g\n",i,v2[i]);
     else{
         printf("v[%d] = %g\n",0,v2[0]);
         printf("v[%d] = %g\n",N-1,v2[N-1]);
     }

  printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:%u\n",elapsed,N);

}

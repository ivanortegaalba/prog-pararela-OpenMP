#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
   #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

main(int argc, char **argv) {
  int N = atoi(argv[1]);
  int i,j;
  int m[N][N];
  int v1[N],v2[N];
  double start,end,elapsed;
  if(argc < 2) {
  	fprintf(stderr,"Faltan argumentos\n");
  	exit(-1);
  }
  //Inicializamos
  for(i = 0; i<N;i++){
    v1[i]= i;
    v2[i] = 0;
    for(j=0;j<N;j++)
      m[i][j] = i + j;
  }

  start = omp_get_wtime();
  int suma=0;
  //Multiplicamos

  for (i = 0; i < N; ++i){
      int suma = 0;
      #pragma omp parallel for reduction(+:suma)
      for (j = 0; j < N; ++j){
          suma += m[i][j] * v1[j];
      }
      v2[i]=suma;
  }


  end = omp_get_wtime();
  elapsed = end - start;
  //Imprimimos
  printf("Vector Resultante\n");
  for(i = 0; i<N;i++)
     printf("v2[%d] = %d\n",i,v2[i]);
  printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:%u\n",elapsed,N);

}

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

main(int argc, char **argv) {
    int N = atoi(argv[1]);
    int i,j,k;
    omp_sched_t kind;
    int modifier;
    double start=0,end=0,elapsed = 0;

    //Matriz 1
    double **a;
    a = (double **) malloc (N*sizeof(double *));
    for (i=0;i<N;i++)
        a[i] = (double *) malloc (N*sizeof(double));
    //Matriz 2
    double **b;
    b = (double **)malloc (N*sizeof(double *));
    for (i=0;i<N;i++)
        b[i] = (double *) malloc (N*sizeof(double));
    //Matriz Resutado
    double **resultado;
    resultado = (double **)malloc (N*sizeof(double *));
    for (i=0;i<N;i++)
        resultado[i] = (double *) malloc (N*sizeof(double));

    if(argc < 2) {
        fprintf(stderr,"Faltan argumentos\n");
        exit(-1);
    }

    for (i=0; i<N; ++i)
        for (j=0; j<N; ++j){
            resultado[i][j] = 0;
            a[i][j] = j+1;
            b[i][j] = j+1;
        }

    //Multiplicamos
    start = omp_get_wtime();
    for (i=0; i<N; ++i){
        for (j=0; j<N; ++j)
            for (k=0; k<N; ++k)
                resultado[i][j] += a[i][k]*b[k][j];
    }
    end = omp_get_wtime();
    elapsed = end - start;

    //Imprimimos
    printf("resultado[0][0] = %g\n",resultado[0][0]);
    printf("resultado[N-1][N-1] = %g\n",resultado[N-1][N-1]);
    printf("Tiempo(seg.):%11.9f\t / Tamaño Matrices:%u\n",elapsed,N);

}

#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>

main(int argc, char **argv)
{
  register double width,x;
  double sum, lsum;
  register int intervals, i; 
  int nproc, iproc;
  MPI_Status status;

  double t;	

  if(argc < 2)     {
          fprintf(stderr,"\nFalta nº intervalos\n");
          exit(-1);
   }
  intervals=atoi(argv[1]);   if (intervals<1) intervals=1;

  t=MPI_Wtime();

  if (MPI_Init(&argc, &argv) != MPI_SUCCESS) exit(1);
  MPI_Comm_size(MPI_COMM_WORLD, &nproc);
  MPI_Comm_rank(MPI_COMM_WORLD, &iproc);

  width = 1.0 / intervals;
  lsum = 0;

  for (i=iproc; i<intervals; i+=nproc) {
    x = (i + 0.5) * width;
    lsum += 4.0 / (1.0 + x * x);
  }

  lsum *= width;

  MPI_Reduce(&lsum,&sum, 1, MPI_DOUBLE,   
                           MPI_SUM, 0, MPI_COMM_WORLD);
 
  MPI_Finalize();

  t=MPI_Wtime()-t;

  if (!iproc) {
      printf("Iteraciones:\t%d\t. PI:\t%26.24f\t. 
                   Procesos:\t%d\t. Tiempo:\t%8.6f\n", 
                   intervals,sum,nproc,t);
  }
  return(0);
}

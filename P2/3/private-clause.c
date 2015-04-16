#include <stdio.h>

#ifdef _OPENMP
   #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

main()
{
   int i, n = 7;
   int a[n], suma=50;

   for (i=0; i<n; i++)
	a[i] = i;

   #pragma omp parallel
   {
     //El valor de entrada es indefinido de la variable private, por lo que
     //siempre tenemos que inicializarla. Lo que se modifica en el bloque paralelo
     //no afecta al valor que tuviese esa variable antes del bloque.
	suma=0;

	#pragma omp for
	for (i=0; i<n; i++)
	{
	   suma = suma + a[i];
	   printf("thread %d suma a[%d] / ", omp_get_thread_num(), i);
	}

	printf("\n* thread %d suma= %d", omp_get_thread_num(), suma);
   }

   printf("\n");
   printf("suma=%d \n",suma);
}

#include <stdio.h>

#ifdef _OPENMP
   #include <omp.h>
#endif

main()
{
   int i, n = 7;
   int a[n];

   for (i=0; i<n; i++)
	a[i] = i+1;

// none significa que cualquier variable usada en una región
//paralela que no estén con private (OpenMP),
//shared (OpenMP), reduction, firstprivate, o la cláusula de lastprivate
//provocará un error del compilador


   #pragma omp parallel for default(none)//shared(a)
   for (i=0; i<n; i++) a[i] += i;

   printf("Después de parallel for:\n");

   for (i=0; i<n; i++)
	printf("a[%d] = %d\n",i,a[i]);
}

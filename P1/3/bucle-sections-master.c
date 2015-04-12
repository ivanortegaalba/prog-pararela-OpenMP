#include <stdio.h>
#include <omp.h>

	void funcA() {
		printf("En funcA: esta sección la ejecuta el thread %d\n",
		omp_get_thread_num());
	}
	void funcB() {
		printf("En funcB: esta sección la ejecuta el thread %d\n",
		omp_get_thread_num());
	}
int main() {
	int i = 0, j = 5, n = 10;

	#pragma omp parallel
	{
		#pragma omp sections
		{
			#pragma omp section
			{
			(void) funcA();
			for (i; i<n/2; i++)
				printf("thread %d ejecuta la iteración %d del bucle\n",omp_get_thread_num(),i);
			}
			#pragma omp section
			{
			(void) funcB();
			for (j; j<n; j++)
				printf("thread %d ejecuta la iteración %d del bucle\n",omp_get_thread_num(),j);
			}
		}
	}
}

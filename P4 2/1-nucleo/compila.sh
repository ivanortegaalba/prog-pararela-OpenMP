mkdir ./$2
gcc -fopenmp $1 -o $2/$2-O0 -O0
gcc -fopenmp $1 -o $2/$2-O1 -O1
gcc -fopenmp $1 -o $2/$2-O2 -O2
gcc -fopenmp $1 -o $2/$2-O3 -O3
gcc -fopenmp $1 -o $2/$2-Os -Os

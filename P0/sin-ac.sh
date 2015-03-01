#!/usr/bin/expect

spawn sftp B3estudiante27@atcgrid.ugr.es
expect "password:"
sleep 1
send "marioortega\r";
expect ">"
send "put * P0\r";
expect ">"
send "bye\r"
spawn ssh B3estudiante27@atcgrid.ugr.es
expect "password:"
sleep 1
send "marioortega\r";
send "cd P0\r";
send "gcc -fopenmp -O2 -o Hello-World Hello-World.c\r";
send "rm helloomp.*\r"
send "qsub Hello-World-PBS_Workdir.sh\r";
send "ls -l\r";
expect eof;

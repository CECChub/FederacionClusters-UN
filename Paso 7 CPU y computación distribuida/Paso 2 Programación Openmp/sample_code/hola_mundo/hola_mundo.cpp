#include <cstdio>
#include <chrono>
#include <thread>
#include <omp.h>

using namespace std;

int main() {

  double ini_time = omp_get_wtime();

  //Región paralelizable**********************
  for(int i = 0; i < 4; i++){
    printf("Hola mundo\n");
    this_thread::sleep_for(chrono::seconds(1));
  }
  //******************************************
  
  double fin_time = omp_get_wtime();

  printf("tiempo: %f s\n",(fin_time-ini_time));

  return 0;
}

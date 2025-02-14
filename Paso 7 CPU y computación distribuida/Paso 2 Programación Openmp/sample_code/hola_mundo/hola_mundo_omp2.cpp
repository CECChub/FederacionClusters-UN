#include <cstdio>
#include <chrono>
#include <thread>
#include <omp.h>

using namespace std;

int main() {
  
  double ini_time = omp_get_wtime();

  //Región paralelizable**********************
  #pragma omp parallel for
  for(int i = 0; i < 4; i++){
    int num_thr = omp_get_num_threads();
    int id = omp_get_thread_num();
    
    printf("Hola mundo. Soy el hilo %d de %d\n",id,num_thr);
    this_thread::sleep_for(chrono::seconds(1));
  }
  //******************************************
  
  double fin_time = omp_get_wtime();

  printf("tiempo: %f s\n",(fin_time-ini_time));

  return 0;
}

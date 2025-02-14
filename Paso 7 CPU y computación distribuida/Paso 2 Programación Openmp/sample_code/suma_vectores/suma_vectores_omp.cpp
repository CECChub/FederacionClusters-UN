#include <cstdlib>
#include <fstream>
#include <chrono>
#include <thread>
#include <omp.h>

using namespace std;

int main(int argc, char **argv) {
  int N = atoi(argv[1]);
  
  int* vector1 = new int[N];
  int* vector2 = new int[N];
  int* result = new int[N];

  for(int i = 0; i < N; i++){
    vector1[i] = 1;
    vector2[i] = 1;
  }

  double ini_time = omp_get_wtime();

  int num_thr = 0;
  int N_rep = 100;
  for(int n = 0; n < N_rep; n++){
    //Región paralelizable**********************
    #pragma omp parallel for schedule(auto)
    for(int i = 0; i < N; i++){
      if(omp_get_thread_num() == 0)
	num_thr = omp_get_num_threads();
	
      result[i] = vector1[i] + vector2[i];
    }
    //******************************************
  }
    
  double fin_time = omp_get_wtime();

  ofstream outf("output_p.txt");
  if(outf.good()){
    outf << "N hilos: " << num_thr << "\n";
    outf << "tiempo prom.: " << (fin_time-ini_time)/N_rep << " s\n";
  
    //Prueba
    int suma = 0;
    for(int i = 0; i < N; i++)
      suma += result[i];
    outf << "suma: " << suma << "\nsuma esperada: "
	 << N*2 << "\n";
  }
  outf.close();
  
  delete[] vector1;
  delete[] vector2;
  delete[] result;
  
  return 0;
}

#include <iostream>
#include <vector>
#include <omp.h>
#include <chrono>

int main() {
    const size_t N = 1000000000;  // Vector size
    std::vector<double> numbers(N);

    // Initialize vector
    #pragma omp parallel for
    for(size_t i = 0; i < N; i++) {
        numbers[i] = i;
    }

    // Measure execution time
    auto start = std::chrono::high_resolution_clock::now();

    double sum = 0.0;
    #pragma omp parallel for reduction(+:sum)
    for(size_t i = 0; i < N; i++) {
        sum += numbers[i];
    }

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    // Print results
    std::cout << "Sum: " << sum << std::endl;
    std::cout << "Time taken: " << duration.count() << " milliseconds" << std::endl;
    std::cout << "Number of threads used: " << omp_get_max_threads() << std::endl;

    return 0;
}

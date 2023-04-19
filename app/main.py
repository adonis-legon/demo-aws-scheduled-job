import sys
import time
import random
from enum import Enum

def count_primes(max):
    sieve = []
    for i in range(max):
        sieve.append(0)

    sieve[0], sieve[1] = 2, 2
    
    i = 2
    count = 0
    while i < len(sieve):
        if sieve[i] == 0:
            sieve[i] = 1
            count += 1

            for j in range(i*i, len(sieve), i):
                sieve[j] = 2

        i += 1

    print(f'There are {count} primes less than {max}')
    return count

def partition(array, low, high):
    pivot = array[high] 
    i = low - 1
 
    for j in range(low, high):
        if array[j] <= pivot:
            i = i + 1
            (array[i], array[j]) = (array[j], array[i])
 
    (array[i + 1], array[high]) = (array[high], array[i + 1])
 
    return i + 1

def quickSort(array, low, high):
    if low < high:
        pi = partition(array, low, high)
 
        quickSort(array, low, pi - 1)
        quickSort(array, pi + 1, high)

def sort(array):
    quickSort(array, 0, len(array) - 1)
    print(f'Sorted an array of {len(array)} elements')

def generate_array(array_size):
    array = []

    for i in range(array_size):
        array.append(random.randint(1, array_size))

    return array

class AlgorithmType(Enum):
    PRIMES = 1
    SORT = 2

DEFAULT_ALGORITH_TYPE = AlgorithmType.PRIMES

if __name__ == '__main__':
    ALGORITHM_TYPE = getattr(AlgorithmType, sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_ALGORITH_TYPE
    
    print(f'Started {ALGORITHM_TYPE.name} algorithm...')
    algorithm_start = time.time()

    if ALGORITHM_TYPE == AlgorithmType.PRIMES:
        MAX_PRIME = 100000000
        count_primes(MAX_PRIME)
    elif ALGORITHM_TYPE == AlgorithmType.SORT:
        MAX_ARRAY_LEN = 10000000
        sort(generate_array(MAX_ARRAY_LEN))
    else:
        print(f'Invalid algorithm type: {sys.argv[1]}')

    algorithm_end = time.time()
    algorithm_diff = round(algorithm_end - algorithm_start, 2)

    print(f'Finished {ALGORITHM_TYPE.name} algorithm. Total time: {algorithm_diff}(s)')

//
// Created by Tian Z on 2021/7/27. (ecburxvip@gmail.com)
//

#include <stdlib.h>
#include <time.h>
#include <stdio.h>

int initialized = 0;

/**
 * An unsafe, predictable and limited random integer generator, in range [lower, upper].
 * Switch <lower> and <upper> if <upper> is LOWER than <lower>.
 * @note This function is only for users who want to easily render random picture elements.
 *       Please don't use it for precise calculations.
 * @param lower Lower bound.
 * @param upper Upper bound.
 * @return A random integer in range.
 */
int randomInt(int lower, int upper) {
    if (upper == lower) return lower;
    if (upper < lower) {
        int tmp = lower;
        lower = upper;
        upper = tmp;
    }

    if (initialized == 0) {
        time_t t;
        srand((unsigned) time(&t));
        initialized = -1;
    }

    return (rand() % (upper - lower + 1)) + lower;
}
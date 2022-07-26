#include <stdio.h>
#include "kvml.h"

int main()
{
    int i, len = 4; 
    float src[len] = {0.0f, INFINITY, NAN, 2.0f}; 
    float* dst = (float*)malloc(sizeof(float) * len); 

    if (dst == NULL) { 
        printf("Malloc Failed!\n");
        return 1;
    }
    vsexp(len, src, dst);

    for(i=0; i<len, i++) {
        printf("dst[%d]=%f\n",i,dst[i]);
    }

    return 0;
}

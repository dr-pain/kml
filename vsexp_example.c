#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "kvml.h"

#define len 4

int main()
{
    int i;
    float src[len] = {0.0f, INFINITY, NAN, 2.0f};
    float* dst = (float*)malloc(sizeof(float) * len);
    KVMLVersion ver;

    KVMLGetVersion(&ver);
    printf("component - %s\n",ver.component);
    printf("version - %s\n",ver.version);
    printf("supportPackage - %s\n",ver.supportPackage);
    printf("compiler - %s\n",ver.compiler);
    printf("compileTime - %s\n",ver.compileTime);

    if (dst == NULL) {
        printf("Malloc Failed!\n");
        return 1;
    }
    vsexp(len, src, dst);

    for(i=0; i<len; i++) {
        printf("dst[%d]=%f\n",i,dst[i]);
    }

    return 0;
}

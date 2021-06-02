//Simple program to test special functions.
#include <stdio.h>

__global__
void saxpy(int n, int a, int x, int y, int z)
{
     z =  3;
     printf("%d", z);
}

int main(void)
{
  int N = 1024;

  int x, y, z;
  int a = 4;
  x=2;
  y=3;
  saxpy<<<5, 10>>>(N, a, x, y, z);
  printf("%d", z);
}
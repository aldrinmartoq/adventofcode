#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <unistd.h>

struct timeval start, ini, fin;
unsigned long length = 1, old_length, increase;
unsigned long max = 12000000000; // ≈ 12 GB of RAM 🙃
int day;
int max_day = 256 + 8;

float delta_time(struct timeval ini, struct timeval fin) {
  long secs = fin.tv_sec - ini.tv_sec;
  long msec = ((secs * 1000000) + fin.tv_usec) - (ini.tv_usec);
  return msec / 1000000.0;
}


int main() {
  char *data = (char *)malloc(max);
  unsigned long growth[max_day + 1];
  memset(data, 9, max);
  memset(growth, 0, max_day);

  gettimeofday(&start, NULL);
  gettimeofday(&ini, NULL);
  gettimeofday(&fin, NULL);

  for (day = 0; day < max_day; day++) {
    gettimeofday(&ini, NULL);
    old_length = length;
    for (long n = 0; n < length; n++) {
      data[n] -= 1;
      if (data[n] < 0) {
        data[n] = 6;
        length++;
      }
    }
    gettimeofday(&fin, NULL);
    increase = length - old_length;
    growth[day + 1] = length;

    printf("Day: %3d time: %6.2f %6.2f count: %12lu increase: %12lu data: ", day, delta_time(start, fin), delta_time(ini, fin), length, increase);
    for (long n = 0; n < 10; n++) {
      printf("%d,", data[n]);
    }
    printf("\n");
  }

  printf("growth = [");
  for (int i = 0; i <= max_day; i++) {
    printf("%lu", growth[i]);
    if (i != max_day) {
      printf(", ");
    }
  }
  printf("]\n");
}

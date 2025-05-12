#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void decompose_f32(float fp, uint8_t *s, uint8_t *e, uint32_t *f) {
  uint32_t bits;
  memcpy(&bits, &fp,
         sizeof(bits));     // Copy the bitwise representation of the float
  *s = (bits >> 31) & 0x1;  // Extract sign bit
  *e = (bits >> 23) & 0xFF; // Extract exponent bits
  *f = bits & 0x7FFFFF;     // Extract fraction bits
}

void decompose_f64(double fp, uint8_t *s, uint16_t *e, uint64_t *f) {
  uint64_t bits;
  memcpy(&bits, &fp,
         sizeof(bits));        // Copy the bitwise representation of the double
  *s = (bits >> 63) & 0x1;     // Extract sign bit
  *e = (bits >> 52) & 0x7FF;   // Extract exponent bits
  *f = bits & 0xFFFFFFFFFFFFF; // Extract fraction bits
}

void normal_numbers(float *f32, double *f64) {
  f32[0] = 69.0f;
  f64[0] = 69.0;
  f32[1] = 3.14f;
  f64[1] = 3.14;
  f32[2] = 1.0f;
  f64[2] = 1.0;
  f32[3] = 2.718f;
  f64[3] = 2.718;
  f32[4] = 1.5f;
  f64[4] = 1.5;
  f32[5] = 12345.6789f;
  f64[5] = 12345.6789;
}

void write_bits(FILE *file, uint64_t value, int bit_count) {
  for (int i = bit_count - 1; i >= 0; i--) {
    uint8_t bit = (value >> i) & 0x1;
    fwrite(&bit, sizeof(bit), 1, file);
  }
}

int factorize() {
  FILE *file_f32 = fopen("decomposed_f32.bin", "wb");
  FILE *file_f64 = fopen("decomposed_f64.bin", "wb");

  if (!file_f32 || !file_f64) {
    printf("Error opening files\n");
    return -1;
  }

  float f32[6];
  double f64[6];
  normal_numbers(f32, f64);

  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 6; j++) {
      uint8_t s1, s2;
      uint8_t e1, e2;
      uint32_t f1, f2;

      decompose_f32(f32[i], &s1, &e1, &f1);
      decompose_f32(f32[j], &s2, &e2, &f2);

      uint16_t e1d, e2d;
      uint64_t f1d, f2d;
      decompose_f64(f64[i], &s1, &e1d, &f1d);
      decompose_f64(f64[j], &s2, &e2d, &f2d);

      write_bits(file_f32, ((uint64_t)s1 << 31) | ((uint64_t)e1 << 23) | f1,
                 32);
      write_bits(file_f32, ((uint64_t)s2 << 31) | ((uint64_t)e2 << 23) | f2,
                 32);

      write_bits(file_f64, ((uint64_t)s1 << 63) | ((uint64_t)e1d << 52) | f1d,
                 64);
      write_bits(file_f64, ((uint64_t)s2 << 63) | ((uint64_t)e2d << 52) | f2d,
                 64);
    }
  }

  printf("Decompositions written to 'decomposed_f32.bin' and "
         "'decomposed_f64.bin'\n");

  fclose(file_f32);
  fclose(file_f64);
  return 0;
}

int main() {
  factorize();
  return 0;
}

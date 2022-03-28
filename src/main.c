#include "main.h"

int main(void) {
  // Enable GPIOB peripheral in 'RCC_AHB1ENR'
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;
}

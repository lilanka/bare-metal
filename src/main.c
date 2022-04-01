#include "main.h"

void SystemInit(void) {}

int main(void) {
  // enable GPIOB peripheral in 'RCC_AHB1ENR'
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;

  // initialize GPIO pins
  GPIOB->MODER &= ~(0x3 << (_gGPIO_RED_LED*2));
  GPIOB->MODER |= ~(0x1 << (_gGPIO_RED_LED*2));
  GPIOB->OTYPER &= ~(1 << _gGPIO_RED_LED);
}

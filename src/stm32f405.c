#include "stm32f405.h"

#include <port.h>
#include <stdbool.h>
#include <stdint.h>

#define LED_0_PIN D13

static void set_output(const uint8_t pin) {
  struct port_config config_port_pin;
  port_get_config_defaults(&config_port_pin);
  config_port_pin.derection = PORT_PIN_DIR_OUTPUT;
  port_pin_set_output_level(pin, false);
}

int main() {
  set_output(LED_0_PIN);
  while (true) {
    port_pin_toggle_output_level(LED_0_PIN);
    for (volatile int i = 0; i < 100000; ++i) {}
  }
}

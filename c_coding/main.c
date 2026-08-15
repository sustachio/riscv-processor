#include <stdint.h>
#include "keycodes.h"
#include "lib.h"
#include "mmio.h"

void draw_items(int selected_item) {
  set_cursor(7,7);
  if (selected_item == 1) set_char_color_palette(COLOR_BLACK, COLOR_YELLOW);
  print("1) Action 1");
  set_char_color_palette(COLOR_BLACK, COLOR_WHITE);

  set_cursor(7,9);
  if (selected_item == 2) set_char_color_palette(COLOR_BLACK, COLOR_YELLOW);
  print("2) Action 2");
  set_char_color_palette(COLOR_BLACK, COLOR_WHITE);

  set_cursor(7,11);
  if (selected_item == 3) set_char_color_palette(COLOR_BLACK, COLOR_YELLOW);
  print("3) Action 3");
  set_char_color_palette(COLOR_BLACK, COLOR_WHITE);
}

int main(void) {
  __asm__ volatile ("ebreak");
  init_color_palette();
  __asm__ volatile ("ebreak");

  int i = 0;
  for (int x=0; x<220; x+=20)
    for (int y=0; y<220; y+=20)
      draw_box_pixels(x, y, x+20, y+20, i++ & 1 ? COLOR_DARK_CYAN : COLOR_BRIGHT_CYAN);

  __asm__ volatile ("ebreak");
  draw_box_chars(5,3,22,15, COLOR_WHITE);


  set_char_color_palette(COLOR_BLACK, COLOR_WHITE);

  set_cursor(6,4);
  print("Simple menu app");
  set_cursor(6,5);
  print("Action: ");

  int selected_item = 1;
  draw_items(selected_item);

  int lastup = 0,lastdown = 0;
  while (1) {
    if (!lastup && KEYBOARD[KEY_UP_ARROW]) {
      if (--selected_item == 0) selected_item = 3;
      draw_items(selected_item);
    }
    lastup = KEYBOARD[KEY_UP_ARROW];

    if (!lastdown && KEYBOARD[KEY_DOWN_ARROW]) {
      if (++selected_item == 4) selected_item = 1;
      draw_items(selected_item);
    }
    lastdown = KEYBOARD[KEY_DOWN_ARROW];

    if (KEYBOARD[KEY_ENTER]) {
      set_char_color_palette(COLOR_BLACK, COLOR_YELLOW);
      display_char(selected_item + '0', 14, 5);
      set_char_color_palette(COLOR_BLACK, COLOR_WHITE);
    }
  };

  return 0;
}
#include <stdint.h>

#include "lib.h"
#include "mmio.h"
#include "ascii.h"

void *memset(void *dst, int c, unsigned long n)
{
    unsigned char *p = dst;
    while (n--)
        *p++ = (unsigned char)c;
    return dst;
}


///////////// GRAPHICS /////////////////

void set_gpu_color_palette(int index, int r, int g, int b) {
  *VGA_PALETTE = ((index & 0b1111) << 12) | ((r & 0b1111) << 8) | ((g & 0b1111) << 4) | (b & 0b1111);
}

//////// TEXT RENDERING

int char_fg_color = COLOR_WHITE;
int char_bg_color = COLOR_BLACK;

int cursor_x = 0; // charecter space
int cursor_y = 0;

// windows 3.1 colors
void init_color_palette() {
  set_gpu_color_palette(COLOR_BLACK,          0 , 0 , 0 );
  set_gpu_color_palette(COLOR_DARK_BLUE,      0 , 0 , 8 );
  set_gpu_color_palette(COLOR_DARK_GREEN,     0 , 8 , 0 );
  set_gpu_color_palette(COLOR_DARK_CYAN,      0 , 8 , 8 );
  set_gpu_color_palette(COLOR_DARK_RED,       8 , 0 , 0 );
  set_gpu_color_palette(COLOR_DARK_MAGENTA,   8 , 0 , 8 );
  set_gpu_color_palette(COLOR_BROWN,          8 , 8 , 0 );
  set_gpu_color_palette(COLOR_LIGHT_GRAY,     12, 12, 12);
  set_gpu_color_palette(COLOR_DARK_GRAY,      8 , 8 , 8 );
  set_gpu_color_palette(COLOR_BRIGHT_BLUE,    0 , 0 , 15);
  set_gpu_color_palette(COLOR_BRIGHT_GREEN,   0 , 15, 0 );
  set_gpu_color_palette(COLOR_BRIGHT_CYAN,    0 , 15, 15);
  set_gpu_color_palette(COLOR_BRIGHT_RED,     15, 0 , 0 );
  set_gpu_color_palette(COLOR_BRIGHT_MAGENTA, 15, 0 , 15);
  set_gpu_color_palette(COLOR_YELLOW,         15, 15, 0 );
  set_gpu_color_palette(COLOR_WHITE,          15, 15, 15);
}

void draw_box_pixels(int startx, int starty, int endx, int endy, int color) {
  for (int y = starty; y < endy; y++) {
    for (int x = startx; x < endx; x++) {
      DRAW_PIXEL(x, y, color);
    }
  }
}
void draw_box_chars(int startx, int starty, int endx, int endy, int color) {
  for (int y = starty * 10; y < endy * 10; y++) {
    for (int x = startx * 6; x < endx * 6; x++) {
      DRAW_PIXEL(x, y, color);
    }
  }
}

// 5x8  pixels per char grid
// 6x10 total, padding: 1 top, 1 bottom, 1 right
void display_char(char c, int x, int y) {
  uint8_t* char_sprite = LETTERS_5x8[(unsigned char)c];

  // pixel space
  x = x * 6;
  y = y * 10;

  // top/bottom padding
  for (int x_offset = 0; x_offset < 6; x_offset++) {
    DRAW_PIXEL(x + x_offset, y,   char_bg_color);
    DRAW_PIXEL(x + x_offset, y+9, char_bg_color);
  }
  // right padding
  for (int y_offset = 0; y_offset < 10; y_offset++)
    DRAW_PIXEL(x + 5, y + y_offset, char_bg_color);

  for (int x_offset=0; x_offset < 5; x_offset++) {
    for (int y_offset=1; y_offset < 9; y_offset++) {
      DRAW_PIXEL(x + x_offset, y + y_offset,
        (((char_sprite[x_offset] >> (8-y_offset)) & 1) ? char_fg_color : char_bg_color)
      );
    }
  }
}

void set_char_color_palette(int fg_color, int bg_color) {
  char_fg_color = fg_color;
  char_bg_color = bg_color;
}

void set_cursor(int x, int y) {
  cursor_x = x;
  cursor_y = y;
};

void print(char* s) {
  unsigned int i = 0;
  unsigned int starting_x = cursor_x;

  while (s[i] != '\0') {
    display_char(s[i], cursor_x, cursor_y);

    if (++cursor_x * 6 > 234 || s[i] == '\n') {
      cursor_x = starting_x;
      cursor_y++;
    }

    i++;
  }
}
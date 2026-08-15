#ifndef LIB_H
#define LIB_H

void *memset(void *dst, int c, unsigned long n);

//////// graphics /////////

#define DRAW_PIXEL(x, y, c) *VGA = (x << 13) | (y << 4) | c

void set_gpu_color_palette(int index, int r, int g, int b);

void draw_box_pixels(int startx, int starty, int endx, int endy, int color); // pixel space
void draw_box_chars(int startx, int starty, int endx, int endy, int color);  // charecter space

///// text display
// todo: add transparent color
#define COLOR_BLACK          0
#define COLOR_DARK_BLUE      1
#define COLOR_DARK_GREEN     2
#define COLOR_DARK_CYAN      3
#define COLOR_DARK_RED       4
#define COLOR_DARK_MAGENTA   5
#define COLOR_BROWN          6 // dark yellow
#define COLOR_LIGHT_GRAY     7
#define COLOR_DARK_GRAY      8
#define COLOR_BRIGHT_BLUE    9
#define COLOR_BRIGHT_GREEN   10
#define COLOR_BRIGHT_CYAN    11
#define COLOR_BRIGHT_RED     12
#define COLOR_BRIGHT_MAGENTA 13
#define COLOR_YELLOW         14
#define COLOR_WHITE          15

extern int char_fg_color;
extern int char_bg_color;

extern int cursor_x;
extern int cursor_y;

void init_color_palette(); // standard 16 colors
void display_char(char c, int x, int y); // charecter space
void set_char_color_palette(int fg_color, int bg_color);
void set_cursor(int x, int y); // charecter space
void print(char* s);

#endif
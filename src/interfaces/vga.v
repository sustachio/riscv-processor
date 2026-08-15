module vga_interface(
  input rst_n,
  input clk,

  output reg [3:0] VGA_R,
  output reg [3:0] VGA_G,
  output reg [3:0] VGA_B,
  output reg VGA_HS,
  output reg VGA_VS,

  input [8:0] pen_x,
  input [8:0] pen_y,
  input [3:0] pen_color,
  input pen_draw,

  // 8 colors, rgb444
  input [3:0] palette_index,
  input [11:0] palette_color,
  input write_palette,

  input debug_show_palette_index
);
  // horizontal timing (in pixles/25MHz clock cycles):
  // (0-95)    sync - 96
  // (96-143)  back porch (right after sync) - 48
  // (144-783) active video 640 (640 pixels wide)
  // (784-799) front porch (right before sync) - 16

  // vertical timing (in lines)
  // (0-1)     sync - 2
  // (2-32)    back porch - 31
  // (33-512)  active video - 480 (480 lines tall)
  // (513-523) front porch - 11

  // counters, not exactly pixles/lines, include porch/sync timing
  reg [9:0] x_counter;
  reg [9:0] y_counter;

  // 220 x 220
  // (main grid is 320 x 240 but we are cropping)
  wire [8:0] x_pixel = ((x_counter - 9'd144) >> 1) - 50;
  wire [8:0] y_pixel = ((y_counter - 9'd33)  >> 1) - 10;

  reg slower_clock;

  // pixel framebuffer, reads must be synchronous
  reg [3:0] pixels [0:43999]; // 220*220-1
  wire [15:0] pixel_addr =       {{7{1'b0}},y_pixel} * 16'd220 + {{7{1'b0}},x_pixel};
  wire [15:0] pixel_write_addr = {{7{1'b0}},pen_y}   * 16'd220 + {{7{1'b0}},pen_x};
  reg [3:0] pixel_data;
  reg [11:0] pixel_color;

  // color pallete rgb444 (ramstyle needed so it doesnt use it with pixels and crap out)
  (* ramstyle = "logic" *) reg [11:0] palette [0:15];

	// must be in its own block to infer ram
  always @(posedge clk) begin
    if (pen_x < 240 && pen_y < 240 && pen_draw && rst_n)
      pixels[pixel_write_addr] <= pen_color;

    pixel_data <= pixels[pixel_addr];
  end

	always @(posedge clk) begin
	    if (write_palette && rst_n)
				palette[palette_index] <= palette_color;
	end

  always @(posedge clk) begin
    if (!rst_n) begin
      slower_clock <= 0;
      x_counter <= 0;
      y_counter <= 0;
    end else begin
      slower_clock <= ~slower_clock;

      if (slower_clock) begin
        if (x_counter >= 799) begin
          x_counter <= 0;

          if (y_counter >= 523) 
            y_counter <= 0;
          else
            y_counter <= y_counter + 10'd1;
        end
        else
          x_counter <= x_counter + 10'd1;
      end
    end
  end

  always @(*) begin
    pixel_color = palette[pixel_data];

    VGA_HS = 1;
    VGA_VS = 1;
    VGA_R = 0;
    VGA_G = 0;
    VGA_B = 0;

    if (rst_n) begin
      // H sync
      if (x_counter <= 95)
        VGA_HS = 0;

      // V sync
      if (y_counter <= 1)
        VGA_VS = 0;

      // not in porches
      //if (144 <= x_counter && x_counter <= 783 &&
          //33  <= y_counter && y_counter <= 512) begin
      if (145 <= x_counter && x_counter <= 783 &&
          34  <= y_counter && y_counter <= 512 &&
          // not in margins
          y_pixel < 220 && x_pixel < 220) begin
        if (debug_show_palette_index) begin
          VGA_R = pixel_data;
          VGA_G = pixel_data;
          VGA_B = pixel_data;
        end else begin
          VGA_R = pixel_color[11:8];
          VGA_G = pixel_color[7:4];
          VGA_B = pixel_color[3:0];
        end
      end
    end
  end
endmodule

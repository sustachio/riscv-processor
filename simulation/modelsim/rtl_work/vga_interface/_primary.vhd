library verilog;
use verilog.vl_types.all;
entity vga_interface is
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        VGA_R           : out    vl_logic_vector(3 downto 0);
        VGA_G           : out    vl_logic_vector(3 downto 0);
        VGA_B           : out    vl_logic_vector(3 downto 0);
        VGA_HS          : out    vl_logic;
        VGA_VS          : out    vl_logic;
        pen_x           : in     vl_logic_vector(8 downto 0);
        pen_y           : in     vl_logic_vector(8 downto 0);
        pen_color       : in     vl_logic_vector(2 downto 0);
        pen_draw        : in     vl_logic;
        palette_index   : in     vl_logic_vector(2 downto 0);
        palette_color   : in     vl_logic_vector(11 downto 0);
        write_palette   : in     vl_logic
    );
end vga_interface;

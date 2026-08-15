library verilog;
use verilog.vl_types.all;
entity memory_mapped_io is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        read_request    : in     vl_logic;
        write_request   : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0);
        finished        : out    vl_logic;
        busy            : out    vl_logic;
        LEDR            : out    vl_logic_vector(9 downto 0);
        vga_pen_x       : out    vl_logic_vector(8 downto 0);
        vga_pen_y       : out    vl_logic_vector(8 downto 0);
        vga_pen_color   : out    vl_logic_vector(2 downto 0);
        vga_pen_draw    : out    vl_logic;
        vga_palette_index: out    vl_logic_vector(2 downto 0);
        vga_palette_color: out    vl_logic_vector(11 downto 0);
        vga_write_palette: out    vl_logic;
        ps2_get_key     : out    vl_logic_vector(6 downto 0);
        ps2_key_pressed : in     vl_logic
    );
end memory_mapped_io;

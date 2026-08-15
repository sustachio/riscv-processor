library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        processor_state : in     vl_logic_vector(2 downto 0);
        instruction32   : in     vl_logic_vector(31 downto 0);
        op              : out    vl_logic_vector(5 downto 0);
        next_op         : out    vl_logic_vector(5 downto 0);
        rd              : out    vl_logic_vector(4 downto 0);
        rs1             : out    vl_logic_vector(31 downto 0);
        rs2             : out    vl_logic_vector(31 downto 0);
        imm             : out    vl_logic_vector(31 downto 0);
        rs1_bank_interface_in: out    vl_logic_vector(4 downto 0);
        rs2_bank_interface_in: out    vl_logic_vector(4 downto 0);
        rs1_bank_interface_out: in     vl_logic_vector(31 downto 0);
        rs2_bank_interface_out: in     vl_logic_vector(31 downto 0)
    );
end decoder;

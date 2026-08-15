`include "global_constants.vh"

module processor_state_manager(
  input clk,
  input rst_n,

  input mem_finished,
  input [5:0] decoder_next_op,

  output reg [2:0] processor_state,

  input TEST_ALLOW_WB_COMPLETE
);
  reg [2:0] next_state;

  always @(*) begin
    case (processor_state)
      `START_FETCH:
        next_state = `FETCH;

      `FETCH: begin
        if (mem_finished) begin
          next_state = `DECODE;
        end
        else
          next_state = `FETCH;
      end

      `DECODE: begin
          case (decoder_next_op)
            `OP_LW, `OP_LB, `OP_LH, `OP_LBU, `OP_LHU, `OP_SW, `OP_SB, `OP_SH:
              next_state = `START_MEM;
            default:
              next_state = `WRITEBACK;
          endcase
      end

      `START_MEM:
        next_state = `MEM_ACCESS;

      `MEM_ACCESS: begin
        if (mem_finished) begin
          next_state = `WRITEBACK;
        end
        else 
          next_state = `MEM_ACCESS;
      end

      `WRITEBACK: begin
        if (TEST_ALLOW_WB_COMPLETE)
          next_state = `START_FETCH;
        else
          next_state = `WRITEBACK;
      end
				
			default: // to make the compiler happy
				next_state = `START_FETCH;
    endcase
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      processor_state <= `START_FETCH;
    else begin
      processor_state <= next_state; 
    end
  end

endmodule

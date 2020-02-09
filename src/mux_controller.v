module mux_controller
  #(
    parameter INPUT_COUNT      = 8,
    parameter INPUT_DATA_WIDTH = 4,
    parameter CLK_FREQUENCY    = 100000000, // Clock frequency
    parameter REFRESH_RATE     = 1)        // Channel switch rate
  (
    input clkIn,
    input rstIn,
    input [INPUT_DATA_WIDTH-1:0] channe0In,
    input [INPUT_DATA_WIDTH-1:0] channe1In,
    input [INPUT_DATA_WIDTH-1:0] channe2In,
    input [INPUT_DATA_WIDTH-1:0] channe3In,
    input [INPUT_DATA_WIDTH-1:0] channe4In,
    input [INPUT_DATA_WIDTH-1:0] channe5In,
    input [INPUT_DATA_WIDTH-1:0] channe6In,
    input [INPUT_DATA_WIDTH-1:0] channe7In,
    output [$clog2(INPUT_COUNT)-1:0] selOut,
    output reg [INPUT_DATA_WIDTH-1:0] channelOut);

  localparam REFRESH_COUNT = CLK_FREQUENCY / REFRESH_RATE;

  integer cnt;

  reg [$clog2(INPUT_COUNT)-1:0] channelSel;

  assign selOut = channelSel;

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      channelSel <= 0;
      cnt        <= 0;
    end
    else begin
      if (cnt == REFRESH_COUNT-1) begin
        channelSel <= channelSel + 1;

        cnt <= 0;
      end
      else begin
        cnt <= cnt + 1;
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      channelOut <= 0;
    end
    else begin
      case (channelSel)
        0 : channelOut <= channe0In;
        1 : channelOut <= channe1In;
        2 : channelOut <= channe2In;
        3 : channelOut <= channe3In;
        4 : channelOut <= channe4In;
        5 : channelOut <= channe5In;
        6 : channelOut <= channe6In;
        7 : channelOut <= channe7In;
        default : channelOut <= 0;
      endcase
    end
  end

endmodule
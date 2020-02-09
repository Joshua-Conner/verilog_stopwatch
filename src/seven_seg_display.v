module seven_seg_display 
  #(
    parameter DIGIT_COUNT = 8, // Number of SSEG displays available
    parameter DP_SEG_EN  = 1'b0,
    parameter ACTIVE_LOW = 1'b1)
  (
    input clkIn,
    input rstIn,
    input [$clog2(DIGIT_COUNT)-1:0] selIn,
    input [3:0] bcdIn,

    output reg [DIGIT_COUNT-1:0] aSegOut,
    output [7:0] cSegOut);

  reg [6:0] ledSeg;

  integer i;


  // Enable anode signal based on selIn
  always @ (posedge clkIn) begin
    for (i = 0; i < DIGIT_COUNT; i = i + 1) begin
      if (i == selIn) begin
        aSegOut[i] = 1'b1 ^ ACTIVE_LOW;
      end
      else begin
        aSegOut[i] = 1'b0 ^ ACTIVE_LOW;
      end
    end
  end

  // Cathod signals controller
  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      ledSeg <= 7'b0000000;
    end
    else begin
      case (bcdIn)
        0 : ledSeg <= 7'b0111111;
        1 : ledSeg <= 7'b0000110;
        2 : ledSeg <= 7'b1011011;
        3 : ledSeg <= 7'b1001111;
        4 : ledSeg <= 7'b1100110;
        5 : ledSeg <= 7'b1101101;
        6 : ledSeg <= 7'b1111101;
        7 : ledSeg <= 7'b0000111;
        8 : ledSeg <= 7'b1111111;
        9 : ledSeg <= 7'b1100111;
        default : ledSeg <= 7'b0000000;
      endcase
    end
  end

  assign cSegOut = (ACTIVE_LOW == 1'b1) ? ~{DP_SEG_EN, ledSeg} : {DP_SEG_EN, ledSeg};
endmodule
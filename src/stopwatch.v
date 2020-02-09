module stopwatch (
  input clkIn,
  input rstIn,
  input [3:0] testIn,
  output [7:0] aSegOut,
  output dpOut,
  output [6:0] cSegOut
);

  seven_seg_display U0 (
    .clkIn(clkIn),
    .rstIn(rstIn),
    .selIn(1'b1),
    .bcdIn(testIn),
    .enDpIn(1'b0),
    .enDisplayOut(),
    .ledSegOut(cSegOut),
    .ledDpOut());

  assign aSegOut = 8'h00;
  assign dpOut = 1'b1;
endmodule
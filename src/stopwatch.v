module stopwatch (
  input clkIn,
  input rstIn,
  output [7:0] aSegOut,
  output [7:0] cSegOut);

  wire [3:0] muxSelData;
  wire [2:0] muxSel;

  mux_controller #(.REFRESH_RATE(480)) DATA_SEL_CONTROLLER (
    .clkIn(clkIn),
    .rstIn(rstIn),
    .channe0In(0),
    .channe1In(1),
    .channe2In(2),
    .channe3In(3),
    .channe4In(4),
    .channe5In(5),
    .channe6In(6),
    .channe7In(7),
    .selOut(muxSel),
    .channelOut(muxSelData));

  seven_seg_display SSEG_CONTROLLER (
    .clkIn(clkIn),
    .rstIn(rstIn),
    .selIn(muxSel),
    .bcdIn(muxSelData),
    .aSegOut(aSegOut),
    .cSegOut(cSegOut));

endmodule
module stopwatch (
  input clkIn,
  input rstIn,
  output [7:0] aSegOut,
  output [7:0] cSegOut);

  wire [3:0] milliBcdOne;
  wire [3:0] milliBcdTen;
  wire [3:0] milliBcdHundred;
  wire [3:0] secondBcdOne;
  wire [3:0] secondBcdTen;
  wire [3:0] minuteBcdOne;
  wire [3:0] minuteBcdTen;
  wire [3:0] hourBcdOne;

  wire [3:0] muxSelData;
  wire [2:0] muxSel;

  stopwatch_counter COUNTER (
    .clkIn(clkIn),
    .rstIn(rstIn),
    .milliBcdOneOut(milliBcdOne),
    .milliBcdTenOut(milliBcdTen),
    .milliBcdHundredOut(milliBcdHundred),
    .secondBcdOneOut(secondBcdOne),
    .secondBcdTenOut(secondBcdTen),
    .minuteBcdOneOut(minuteBcdOne),
    .minuteBcdTenOut(minuteBcdTen),
    .hourBcdOneOut(hourBcdOne));

  mux_controller #(.REFRESH_RATE(480)) DATA_SEL_CONTROLLER (
    .clkIn(clkIn),
    .rstIn(rstIn),
    .channe0In(milliBcdOne),
    .channe1In(milliBcdTen),
    .channe2In(milliBcdHundred),
    .channe3In(secondBcdOne),
    .channe4In(secondBcdTen),
    .channe5In(minuteBcdOne),
    .channe6In(minuteBcdTen),
    .channe7In(hourBcdOne),
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
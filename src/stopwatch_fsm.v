module stopwatch_fsm
  (
    input clkIn,
    input rstIn,
    input btnRunIn,
    input btnPauseIn,
    input btnClearIn,
    output reg enCounterOut,
    output reg clrCounterOut);

    parameter IDLE  = 4'b0001;
    parameter RUN   = 4'b0010;
    parameter PAUSE = 4'b0100;
    parameter CLEAR = 4'b1000;

    reg [3:0] state;

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      state         <= IDLE;
      enCounterOut  <= 1'b0;
      clrCounterOut <= 1'b0;
    end
    else begin
      case (state)
        IDLE:
          begin
            enCounterOut  <= 1'b0;
            clrCounterOut <= 1'b0;

            if (btnRunIn == 1'b1) begin
              state <= RUN;
            end
            else if (btnClearIn == 1'b1) begin
              state <= CLEAR;
            end
          end
        RUN:
          begin
            enCounterOut  <= 1'b1;
            clrCounterOut <= 1'b0;

            if (btnPauseIn == 1'b1) begin
              state <= PAUSE;
            end
            else if (btnClearIn == 1'b1) begin
              state <= CLEAR;
            end
          end
        PAUSE:
          begin
            enCounterOut  <= 1'b0;
            clrCounterOut <= 1'b0;

            if (btnRunIn == 1'b1) begin
              state <= RUN;
            end
            else if (btnClearIn == 1'b1) begin
              state <= CLEAR;
            end
          end
        CLEAR:
          begin
            enCounterOut  <= 1'b0;
            clrCounterOut <= 1'b1;

            state <= IDLE;
          end
        default: state <= IDLE;
      endcase
    end
  end
endmodule
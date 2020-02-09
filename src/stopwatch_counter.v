module stopwatch_counter
  (
    input clkIn,
    input rstIn,
    output reg [3:0] milliBcdOneOut,
    output reg [3:0] milliBcdTenOut,
    output reg [3:0] milliBcdHundredOut,
    output reg [3:0] secondBcdOneOut,
    output reg [3:0] secondBcdTenOut,
    output reg [3:0] minuteBcdOneOut,
    output reg [3:0] minuteBcdTenOut,
    output reg [3:0] hourBcdOneOut);

  localparam UPDATE_COUNT = 100000000 / 1000;

  reg incrMilliBcdOneCnt;
  reg incrMilliBcdTenCnt;
  reg incrMilliBcdHundredCnt;
  reg incrSecondBcdOneCnt;
  reg incrSecondBcdTenCnt;
  reg incrMinuteBcdOneCnt;
  reg incrMinuteBcdTenCnt;
  reg incrHourBcdOneCnt;

  integer cnt;

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      cnt <= 0;
      incrMilliBcdOneCnt <= 1'b0;
    end
    else begin
      incrMilliBcdOneCnt <= 1'b0;

      if (cnt == UPDATE_COUNT-1) begin
        incrMilliBcdOneCnt <= 1'b1;
        
        cnt <= 0;
      end
      else begin
        cnt <= cnt + 1;
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      milliBcdOneOut     <= 0;
      incrMilliBcdTenCnt <= 1'b0;
    end
    else begin
      incrMilliBcdTenCnt <= 1'b0;

      if (milliBcdOneOut == 10) begin
        incrMilliBcdTenCnt <= 1'b1;

        milliBcdOneOut <= 0;
      end
      else begin
        if (incrMilliBcdOneCnt == 1'b1) begin
          milliBcdOneOut <= milliBcdOneOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      milliBcdTenOut     <= 0;
      incrMilliBcdHundredCnt <= 1'b0;
    end
    else begin
      incrMilliBcdHundredCnt <= 1'b0;

      if (milliBcdTenOut == 10) begin
        incrMilliBcdHundredCnt <= 1'b1;

        milliBcdTenOut <= 0;
      end
      else begin
        if (incrMilliBcdTenCnt == 1'b1) begin
          milliBcdTenOut <= milliBcdTenOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      milliBcdHundredOut     <= 0;
      incrSecondBcdOneCnt <= 1'b0;
    end
    else begin
      incrSecondBcdOneCnt <= 1'b0;

      if (milliBcdHundredOut == 10) begin
        incrSecondBcdOneCnt <= 1'b1;

        milliBcdHundredOut <= 0;
      end
      else begin
        if (incrMilliBcdHundredCnt == 1'b1) begin
          milliBcdHundredOut <= milliBcdHundredOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      secondBcdOneOut     <= 0;
      incrSecondBcdTenCnt <= 1'b0;
    end
    else begin
      incrSecondBcdTenCnt <= 1'b0;

      if (secondBcdOneOut == 10) begin
        incrSecondBcdTenCnt <= 1'b1;

        secondBcdOneOut <= 0;
      end
      else begin
        if (incrSecondBcdOneCnt == 1'b1) begin
          secondBcdOneOut <= secondBcdOneOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      secondBcdTenOut     <= 0;
      incrMinuteBcdOneCnt <= 1'b0;
    end
    else begin
      incrMinuteBcdOneCnt <= 1'b0;

      if (secondBcdTenOut == 6) begin
        incrMinuteBcdOneCnt <= 1'b1;

        secondBcdTenOut <= 0;
      end
      else begin
        if (incrSecondBcdTenCnt == 1'b1) begin
          secondBcdTenOut <= secondBcdTenOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      minuteBcdOneOut     <= 0;
      incrMinuteBcdTenCnt <= 1'b0;
    end
    else begin
      incrMinuteBcdTenCnt <= 1'b0;

      if (minuteBcdOneOut == 10) begin
        incrMinuteBcdTenCnt <= 1'b1;

        minuteBcdOneOut <= 0;
      end
      else begin
        if (incrMinuteBcdOneCnt == 1'b1) begin
          minuteBcdOneOut <= minuteBcdOneOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      minuteBcdTenOut     <= 0;
      incrHourBcdOneCnt <= 1'b0;
    end
    else begin
      incrHourBcdOneCnt <= 1'b0;

      if (minuteBcdTenOut == 6) begin
        incrHourBcdOneCnt <= 1'b1;

        minuteBcdTenOut <= 0;
      end
      else begin
        if (incrMinuteBcdTenCnt == 1'b1) begin
          minuteBcdTenOut <= minuteBcdTenOut + 1;
        end
      end
    end
  end

  always @ (posedge clkIn) begin
    if (rstIn == 1'b1) begin
      hourBcdOneOut <= 0;
    end
    else begin
      if (hourBcdOneOut == 10) begin
        hourBcdOneOut <= 0;
      end
      else begin
        if (incrHourBcdOneCnt == 1'b1) begin
          hourBcdOneOut <= hourBcdOneOut + 1;
        end
      end
    end
  end
endmodule
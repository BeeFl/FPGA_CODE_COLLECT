logic [2:0] button_sync;
logic       counter_en;
logic [7:0] counter;

always @(posedge clk) begin
  button_down <= '0;
  button_sync <= button_sync << 1 | BTNC;
  if (button_sync[2:1] == 2'b01) counter_en <= '1;
  else if (~button_sync[1])      counter_en <= '0;

  if (counter_en) begin
    counter <= counter + 1'b1;
    if (&counter) begin
      counter_en <= '0;
      counter    <= '0;
      button_down <= '1;
    end
  end
end

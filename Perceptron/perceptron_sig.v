module perceptron_sig #(parameter COUNTER_END = 5)
(
  input clk,
  input rstn,
  input activation_function,
  input [31:0] counter,
  input [31:0] b,
  input [31:0] w,         // Input for weights
  input [31:0] x,         // Input for data
  output [31:0] data_out
);

  parameter NEURON_WIDTH = 5;
  wire [31:0] bus_mult_result;
  wire [31:0] bus_adder;
  reg [31:0] counter1, counter2, counter3, counter4, counter5;
  reg [31:0] counter6, counter7, counter8, counter9, counter10;
  
  // Shift registers for counter delays
  always @ (posedge clk) begin
    counter1 <= counter;
    counter2 <= counter1;
    counter3 <= counter2;
    counter4 <= counter3;
    counter5 <= counter4;
    counter6 <= counter5;
    counter7 <= counter6;
    counter8 <= counter7;
    counter9 <= counter8;
    counter10 <= counter9;
  end
  
  // Multiplication using input weights and data
  multiplier MP1
  (
    .clk (clk),
    .rstn (rstn),
    .counter (counter),
    .w (w),            // Weight is passed as input
    .x (x),            // Data is passed as input
    .mult_result (bus_mult_result)
  );
  
  // Adder module
  adder AD1(
    .clk (clk),
    .rstn (rstn),
    .counter (counter4),
    .value_in (bus_mult_result),
    .bias (b),
    .value_out (bus_adder)
  );
  
  // ReLU activation and output
  SigMoid #(.COUNTER_END(COUNTER_END)) activation(
    .clk (clk),
    .rstn (rstn),
    .activation_function(activation_function),
    .counter (counter10),
    .mult_sum_in (bus_adder),
    .neuron_out (data_out)
  );

endmodule
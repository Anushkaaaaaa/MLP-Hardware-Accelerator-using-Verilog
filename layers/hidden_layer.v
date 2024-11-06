module hidden_layer #(parameter WIDTH = 5)
(
  input clk,
  input rstn,
  input activation_function,
  input [31:0] data_in1,
  input [31:0] data_in2,
  input [31:0] data_in3,
  input [31:0] data_in4,
  input [31:0] b1,
  input [31:0] b2,
  input [31:0] b3,
  input [31:0] b4,
  input [31:0] b5,
  input [31:0] b6,
  input [31:0] b7,
  input [31:0] b8,
  input [31:0] counter,
  output [31:0] data_out1,
  output [31:0] data_out2,
  output [31:0] data_out3,
  output [31:0] data_out4,
  output [31:0] data_out5,
  output [31:0] data_out6,
  output [31:0] data_out7,
  output [31:0] data_out8
);

  reg [31:0] weights_ram1 [0:WIDTH-1];
  reg [31:0] weights_ram2 [0:WIDTH-1];
  reg [31:0] weights_ram3 [0:WIDTH-1];
  reg [31:0] weights_ram4 [0:WIDTH-1];
  reg [31:0] weights_ram5 [0:WIDTH-1];
  reg [31:0] weights_ram6 [0:WIDTH-1];
  reg [31:0] weights_ram7 [0:WIDTH-1];
  reg [31:0] weights_ram8 [0:WIDTH-1];
  
  reg [31:0] data_ram     [0:WIDTH-1];
  
initial begin
	$readmemh("w21.hex", weights_ram1);
	$readmemh("w22.hex", weights_ram2);
	$readmemh("w23.hex", weights_ram3);
	$readmemh("w24.hex", weights_ram4);
	$readmemh("w25.hex", weights_ram5);
	$readmemh("w26.hex", weights_ram6);
	$readmemh("w27.hex", weights_ram7);
	$readmemh("w28.hex", weights_ram8);
	
	data_ram[0] = 32'b00000000000000000000000000000000;
	data_ram[1] = data_in1;
	data_ram[2] = data_in2;
	data_ram[3] = data_in3;
	data_ram[4] = data_in4;
end

  perceptron #( .COUNTER_END(5) ) P21 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b1),           // Example bias input
    .w(weights_ram1[counter ]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out1)
  );
  
  perceptron #( .COUNTER_END(5) ) P22 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b2),           // Example bias input
    .w(weights_ram2[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out2)
  );
  
  perceptron #( .COUNTER_END(5) ) P23 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b3),           // Example bias input
    .w(weights_ram3[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out3)
  );
  
  perceptron #( .COUNTER_END(5) ) P24 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b4),           // Example bias input
    .w(weights_ram4[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out4)
  );
  
  perceptron #( .COUNTER_END(5) ) P25 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b1),           // Example bias input
    .w(weights_ram5[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out5)
  );
  
  perceptron #( .COUNTER_END(5) ) P26 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b2),           // Example bias input
    .w(weights_ram6[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out6)
  );
  
  perceptron #( .COUNTER_END(5) ) P27 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b3),           // Example bias input
    .w(weights_ram7[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out7)
  );
  
  perceptron #( .COUNTER_END(5) ) P28 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b4),           // Example bias input
    .w(weights_ram8[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out8)
  );
  
endmodule
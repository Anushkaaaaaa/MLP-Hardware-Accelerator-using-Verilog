module first_layer #(parameter WIDTH = 5)
(
  input clk,
  input rstn,
  input activation_function,
  input [31:0] data_in1,
  input [31:0] data_in2,
  input [31:0] data_in3,
  input [31:0] data_in4,
  output [31:0] data_out1,
  output [31:0] data_out2,
  output [31:0] data_out3,
  output [31:0] data_out4
);

  reg [31:0] weights_ram1 [0:WIDTH-1];
  reg [31:0] weights_ram2 [0:WIDTH-1];
  reg [31:0] weights_ram3 [0:WIDTH-1];
  reg [31:0] weights_ram4 [0:WIDTH-1];
  reg [31:0] b1;
  reg [31:0] b2;
  reg [31:0] b3;
  reg [31:0] b4;
  
  reg [31:0] data_ram     [0:WIDTH-1];
  
  wire [31:0] bus_counter;
  wire [31:0] counter;
  
initial begin
	$readmemh("w1.hex", weights_ram1);
	$readmemh("w2.hex", weights_ram2);
	$readmemh("w3.hex", weights_ram3);
	$readmemh("w4.hex", weights_ram4);
	
	data_ram[0] = 32'b00000000000000000000000000000000;
	data_ram[1] = data_in1;
	data_ram[2] = data_in2;
	data_ram[3] = data_in3;
	data_ram[4] = data_in4;
	
	b1 = 32'b00111111001111110100010110000000;
	b2 = 32'b00111110110101100101110111110011;
	b3 = 32'b00111111000101001111101011001010;
	b4 = 32'b10111110011111101111110001101101;
end

  perceptron #( .COUNTER_END(5) ) P1 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b1),           // Example bias input
    .w(weights_ram1[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out1)
  );
  
  perceptron #( .COUNTER_END(5) ) P2 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b2),           // Example bias input
    .w(weights_ram2[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out2)
  );
  
  perceptron #( .COUNTER_END(5) ) P3 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b3),           // Example bias input
    .w(weights_ram3[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out3)
  );
  
  perceptron #( .COUNTER_END(5) ) P4 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b4),           // Example bias input
    .w(weights_ram4[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out4)
  );
  
	counter_L1 C1(
		.clk(clk),
		.rstn(rstn),
		.index(counter)
	);
  
endmodule
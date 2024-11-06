module output_layer #(parameter WIDTH = 5)
(
  input clk,
  input rstn,
  input activation_function,
  input [31:0] data_in1,
  input [31:0] data_in2,
  input [31:0] data_in3,
  input [31:0] data_in4,
  output [31:0] data_out1
);

  reg [31:0] weights_ram1 [0:WIDTH-1];
  reg [31:0] data_ram     [0:WIDTH-1];
  reg [31:0] b1;
  wire [31:0] counter;
  
initial begin
	$readmemh("w31.hex", weights_ram1);
	
	
	
	b1 = 32'b00111110010010000110000101010100;
end

always@(posedge clk) begin
	if(rstn) begin
		data_ram[0] <= 32'b00000000000000000000000000000000;
		data_ram[1] <= data_in1;
		data_ram[2] <= data_in2;
		data_ram[3] <= data_in3;
		data_ram[4] <= data_in4;
	end
end

  perceptron_sig #( .COUNTER_END(5) ) P31 (
    .clk(clk),
    .rstn(rstn),
    .activation_function(activation_function),  // Example activation function input
    .counter(counter),
    .b(b1),           // Example bias input
    .w(weights_ram1[counter]),    // Passing weights from hex file
    .x(data_ram[counter]),       // Passing data from hex file
    .data_out(data_out1)
  );
  
  counter_L1 C1(
		.clk(clk),
		.rstn(rstn),
		.index(counter)
	);
  
endmodule

module adder #(parameter COUNTER_END = 4)
(
  input clk,
  input rstn,
  input [31:0] counter,
  input [31:0] value_in,
  input [31:0] bias,
  output reg [31:0] value_out);
  
  wire [31:0] fpu_result;
  reg [31:0] fpu_result1;
  wire fpu_ready;
  wire [31:0] opb_in;
  	reg [31:0] counter1;
	reg [31:0] counter2;
	reg [31:0] counter3;
	reg [31:0] counter4;
	reg [31:0] counter5;
	reg [31:0] counter6;

  // FPU module instantiation
  fpu u_fpu (
    .clk_i(clk),
    .opa_i(fpu_result1),
    .opb_i(opb_in),
    .fpu_op_i(3'b000), 
    .rmode_i(2'b00),  
    .start_i(1'b1),
    .output_o(fpu_result),
    .ready_o(fpu_ready),
    .ine_o(),
    .overflow_o(),
    .underflow_o(),
    .div_zero_o(),
    .inf_o(),
    .zero_o(),
    .qnan_o(),
    .snan_o()
  );
  

	assign opb_in = (counter>COUNTER_END) ? bias:value_in;
	
  always @ (posedge clk) begin
		counter1 <= counter;
	end
	
	always @(posedge clk) begin
		counter2 <= counter1;
	end

	 always @ (posedge clk) begin
		counter3 <= counter2;
	end
	
	always @(posedge clk) begin
		counter4 <= counter3;
	end
	
	always @(posedge clk) begin
		counter5 <= counter4;
	end
	
	always @(posedge clk) begin
		counter6 <= counter5;
	end
	
	always @ (posedge clk) begin
    if (counter==0)
      fpu_result1 <= 0;
    else if (counter6==counter)
      fpu_result1 <= fpu_result;
  end
	
  always @ (counter6) begin
    if (! rstn)
      value_out <= 0;
    else 
      value_out <= fpu_result;
  end
  
endmodule
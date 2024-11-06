module multiplier
( 
  input clk,
  input rstn,
  input [31:0] counter,
  input [31:0] w,
  input [31:0] x,
  output reg [31:0] mult_result);
  
  
  // Wires to connect to the FPU
  wire [31:0] fpu_result;
  wire fpu_ready;
	reg [31:0] counter1;
	reg [31:0] counter2;
	reg [31:0] counter3;
	reg [31:0] counter4;
  // FPU module instantiation
  fpu u_fpu (
    .clk_i(clk),
    .opa_i(w),
    .opb_i(x),
    .fpu_op_i(3'b010), 
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
		
  always @ (counter4) begin
    if (! rstn)
      mult_result <= 32'b00000000000000000000000000000000;
    else if (fpu_ready)
      mult_result <= fpu_result[31:0];
  end
endmodule

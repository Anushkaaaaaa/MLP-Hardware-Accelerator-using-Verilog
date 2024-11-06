module SigMoid #(parameter COUNTER_END = 4)
(
  input clk,
  input rstn,                    // Added reset signal
  input activation_function,     // 1 for ReLU, 0 for none
  input [31:0] counter,
  input [31:0] mult_sum_in,
  output reg [31:0] neuron_out
);



always @(posedge clk or negedge rstn) begin
  if (!rstn) begin
    neuron_out <= 0; // Reset neuron_output to 0
  end else if (counter >= COUNTER_END) begin
	 if (activation_function) begin
	 
		neuron_out[31] <= 1'b0;
		if ((mult_sum_in[30:23] > 'd129)) begin
			neuron_out[30:23] <= mult_sum_in[31] ? 8'd0 : 8'd127;
		end
		else if ((mult_sum_in[30:23] == 'd129)) begin 
			if (mult_sum_in[31]) begin
				if (~mult_sum_in[22]) begin
					neuron_out[30:23] <= 8'd121;
				end
				else if (~mult_sum_in[21]) begin 
					neuron_out[30:23] <= 8'd120;
				end
				else if (~mult_sum_in[20]) begin 
					neuron_out[30:23] <= 8'd119;
				end
				else if (~mult_sum_in[19]) begin 
					neuron_out[30:23] <= 8'd118;
				end
				else begin
					neuron_out[30:23] <= 8'd0;
				end
			end
			else begin
				neuron_out[30:23] <= 8'd126;
			end
		end
		else if ((mult_sum_in[30:23] == 'd128)) begin 
			neuron_out[30:23] <= mult_sum_in[31] ? mult_sum_in[22] ? 8'd122 : 8'd123 : 8'd126;
		end
		else if ((mult_sum_in[30:23] == 'd127)) begin 
			neuron_out[30:23] <= mult_sum_in[31] ? 8'd124 : 8'd126;
		end
		else if ((mult_sum_in[30:23] < 'd127)) begin 
			neuron_out[30:23] <= mult_sum_in[31] ? 8'd125 : 8'd126;
		end
		
		  if ((mult_sum_in[30:23] > 'd129)) begin
			 neuron_out[22:0] <= 23'd0;
		  end
		  else if ((mult_sum_in[30:23] == 'd129)) begin 
			 neuron_out[22:0] <= mult_sum_in[31] ? 23'd0 : {4'he,mult_sum_in[22:4]};
		  end
		  else if ((mult_sum_in[30:23] == 'd128)) begin 
			 neuron_out[22:0] <= mult_sum_in[31] ? {~mult_sum_in[22:0],1'h0} : {3'h6,mult_sum_in[22:3]};
		  end
		  else if ((mult_sum_in[30:23] == 'd127)) begin 
			 neuron_out[22:0] <= mult_sum_in[31] ? ~mult_sum_in[22:0] : {2'h2,mult_sum_in[22:2]};
		  end
		  else if ((mult_sum_in[30:23] == 'd126)) begin 
			 neuron_out[22:0] <= mult_sum_in[31] ? {1'h0,~mult_sum_in[22:1]} : {2'h1,mult_sum_in[22:2]};
		  end
		  else if ((mult_sum_in[30:23] == 'd125)) begin 
			 neuron_out[22:0] <= mult_sum_in[31] ? {2'h2,~mult_sum_in[22:2]} : {3'h1,mult_sum_in[22:3]};
		  end
		  else if ((mult_sum_in[30:23] == 'd124)) begin 
			 neuron_out[22:0] <= mult_sum_in[31] ? {3'h6,~mult_sum_in[22:3]} : {4'h1,mult_sum_in[22:4]};
		  end
		  else begin
			 neuron_out[22:0] <= mult_sum_in[31] ? {4'he,~mult_sum_in[22:4]} : {5'h1,mult_sum_in[22:5]};
		  end
	 end else begin
      neuron_out <= mult_sum_in; // No activation function, pass through
    end
  end else begin
    neuron_out <= neuron_out; // Hold the previous value if the counter condition is not met
  end
end


endmodule
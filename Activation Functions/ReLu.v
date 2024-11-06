module ReLu #(parameter COUNTER_END = 4)
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
    neuron_out <= 0; // Reset output to 0
  end else if (counter >= COUNTER_END) begin
    if (activation_function) begin
      // Check if mult_sum_in is negative
      if (mult_sum_in[31]) begin
        neuron_out <= 0; // If negative, output 0 (ReLU behavior)
      end else begin
        neuron_out <= mult_sum_in; // If positive, output the same value
      end
    end else begin
      neuron_out <= mult_sum_in; // No activation function, pass through
    end
  end else begin
    neuron_out <= neuron_out; // Hold the previous value if the counter condition is not met
  end
end

endmodule


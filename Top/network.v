module network (
    input clk,
    input rstn,
    output [31:0] prediction,
	 output reg pred_ready
	 );
    
    wire [31:0] out1_L1, out2_L1, out3_L1, out4_L1; // First layer outputs
    reg [31:0] out1_L1_latched, out2_L1_latched, out3_L1_latched, out4_L1_latched; // Latched outputs for output layer
    reg [6:0] counter, counter1;      // 7-bit counter to count 65 clock cycles
    reg rstn1;              // rstn signal for output layer
	 reg [31:0] data_in1, data_in2, data_in3, data_in4;

    // Initialize data_ram and reset-related variables
    initial begin
        counter = 0;
        rstn1 = 0;
		  pred_ready = 0;
		  data_in1 = 32'b01000001010010100011110101110001;
		  data_in2 = 32'b00111111101011100001010001111011;
		  data_in3 = 32'b01000000000000010100011110101110;
		  data_in4 = 32'b01000001100001100110011001100110;
    end

    // Counter to keep track of 65 clock cycles and latch first layer outputs
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            counter <= 0;
            rstn1 <= 0;
        end else if (counter < 65) begin
            counter <= counter + 1;
        end else if (counter == 65) begin
            // Latch first layer outputs after 65 clock cycles
            out1_L1_latched <= out1_L1;
            out2_L1_latched <= out2_L1;
            out3_L1_latched <= out3_L1;
            out4_L1_latched <= out4_L1;
				counter <= counter +1;
            rstn1 <= 1; // Assert rstn1 for output layer after latching
        end
    end
	 
	 always @(posedge clk) begin
		if(!rstn1) begin
			counter1 <= 0;
		end else begin
			if (counter1 < 65) begin
				counter1 <= counter1 + 1;
			end else if (counter1 == 65) begin
				pred_ready <= 1'b1;
			end
		end
	 end

    // First layer instantiation
    first_layer #( .WIDTH(5)) layer1 (
        .clk(clk),
        .rstn(rstn),
        .activation_function(1'b1),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .data_in4(data_in4),
        .data_out1(out1_L1),
        .data_out2(out2_L1),
        .data_out3(out3_L1),
        .data_out4(out4_L1)
    );

    // Output layer instantiation, using latched outputs from first layer
    output_layer #( .WIDTH(5)) layer2 (
        .clk(clk),
        .rstn(rstn1),
        .activation_function(1'b1),
        .data_in1(out1_L1_latched),
        .data_in2(out2_L1_latched),
        .data_in3(out3_L1_latched),
        .data_in4(out4_L1_latched),
        .data_out1(prediction)
    );

endmodule
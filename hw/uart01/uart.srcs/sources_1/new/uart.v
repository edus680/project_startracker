`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 14:14:49
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module uart(
    //input clk,
    //input reset,
    //input rx,
    //input [7:0] data_in,
    //input data_in_valid,
    //output [7:0] data_out,
    //output tx,
    //output tx_ready,
    //output busy
  //  );
//endmodule

module uart #(
    parameter CLK_FREQ = 50000000,      // 50 MHz
    parameter BAUD_RATE = 115200,
    parameter DATA_WIDTH = 8            // 8-bit veri
)(
    input wire clk,
    input wire reset,
    input wire rx,                      // Şu an kullanılmıyor
    input wire [DATA_WIDTH-1:0] data_in,
    input wire data_in_valid,

    output reg [DATA_WIDTH-1:0] data_out, // Şu an kullanılmıyor
    output reg tx,
    output reg tx_ready,
    output reg busy
);

    localparam BIT_PERIOD = CLK_FREQ / BAUD_RATE;

    reg [15:0] clk_counter = 0;
    reg [3:0] bit_index = 0;
    reg [DATA_WIDTH-1:0] shift_reg = 0;
    reg sending = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx <= 1'b1;  // IDLE
            tx_ready <= 1;
            busy <= 0;
            clk_counter <= 0;
            bit_index <= 0;
            sending <= 0;
        end else begin
            if (data_in_valid && tx_ready) begin
                // Veri geldi, başla
                sending <= 1;
                tx_ready <= 0;
                busy <= 1;
                shift_reg <= data_in;
                bit_index <= 0;
                clk_counter <= 0;
                tx <= 0; // Start bit
            end else if (sending) begin
                if (clk_counter < BIT_PERIOD) begin
                    clk_counter <= clk_counter + 1;
                end else begin
                    clk_counter <= 0;
                    if (bit_index < DATA_WIDTH) begin
                        tx <= shift_reg[bit_index];
                        bit_index <= bit_index + 1;
                    end else begin
                        tx <= 1; // Stop bit
                        sending <= 0;
                        busy <= 0;
                        tx_ready <= 1;
                    end
                end
            end
        end
    end

endmodule
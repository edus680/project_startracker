`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 14:27:57
// Design Name: 
// Module Name: uarttest
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




module uarttest;

    reg clk = 0;
    reg reset = 1;
    reg rx = 1;
    reg [7:0] data_in = 8'hA5;
    reg data_in_valid = 0;
    wire tx;
    wire [7:0] data_out;
    wire tx_ready;
    wire busy;

    uart uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_in(data_in),
        .data_in_valid(data_in_valid),
        .tx(tx),
        .data_out(data_out),
        .tx_ready(tx_ready),
        .busy(busy)
    );

    always #10 clk = ~clk;  // 50 MHz clock

    initial begin
        #50 reset = 0;
        #100 data_in_valid = 1;
        #20  data_in_valid = 0;

        #100000 $finish;
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module heartbeat (
    input wire clk,         // 10 MHz clock
    input wire rst_n,       // active-low reset
    output reg hb_led       // heartbeat output
);

    reg [23:0] counter;     // 24-bit counter to count 10M cycles

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 24'd0;
            hb_led <= 1'b0;
        end else begin
            if (counter == 24'd9999999) begin // toggle every 10M clocks = 1 second
                counter <= 24'd0;
                hb_led <= ~hb_led; // toggle the heartbeat
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule


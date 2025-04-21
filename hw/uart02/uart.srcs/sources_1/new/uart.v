module uart #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 115200,
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire rx,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire data_in_valid,

    output reg [DATA_WIDTH-1:0] data_out,
    output reg data_out_valid,
    output reg tx,
    output reg tx_ready,
    output reg busy
);

    localparam BIT_PERIOD = CLK_FREQ / BAUD_RATE;

    // Transmitter
    reg [15:0] tx_clk_counter;
    reg [3:0] tx_bit_index;
    reg [DATA_WIDTH-1:0] tx_shift_reg;
    reg tx_sending;

    // Receiver
    reg [15:0] rx_clk_counter;
    reg [3:0] rx_bit_index;
    reg [DATA_WIDTH-1:0] rx_shift_reg;
    reg rx_receiving;
    reg [1:0] rx_sync;

    // RX input sync
    always @(posedge clk)
        rx_sync <= {rx_sync[0], rx};

    // UART logic
    always @(posedge clk) begin
        if (reset) begin
            // TX reset
            tx <= 1'b1;
            tx_ready <= 1;
            tx_sending <= 0;
            tx_clk_counter <= 0;
            tx_bit_index <= 0;

            // RX reset
            data_out <= 0;
            data_out_valid <= 0;
            rx_clk_counter <= 0;
            rx_bit_index <= 0;
            rx_shift_reg <= 0;
            rx_receiving <= 0;

            // Busy flag
            busy <= 0;

        end else begin
            busy <= tx_sending || rx_receiving;

            // Transmitter
            if (data_in_valid && tx_ready) begin
                tx_sending <= 1;
                tx_ready <= 0;
                tx_shift_reg <= data_in;
                tx_bit_index <= 0;
                tx_clk_counter <= 0;
                tx <= 0; // Start bit
            end else if (tx_sending) begin
                if (tx_clk_counter < BIT_PERIOD - 1)
                    tx_clk_counter <= tx_clk_counter + 1;
                else begin
                    tx_clk_counter <= 0;
                    if (tx_bit_index < DATA_WIDTH) begin
                        tx <= tx_shift_reg[tx_bit_index];
                        tx_bit_index <= tx_bit_index + 1;
                    end else begin
                        tx <= 1; // Stop bit
                        tx_sending <= 0;
                        tx_ready <= 1;
                    end
                end
            end

            // Receiver
            data_out_valid <= 0;
            if (!rx_receiving && rx_sync[1] == 0) begin
                rx_receiving <= 1;
                rx_clk_counter <= BIT_PERIOD + (BIT_PERIOD / 2);
                rx_bit_index <= 0;
            end else if (rx_receiving) begin
                if (rx_clk_counter > 0)
                    rx_clk_counter <= rx_clk_counter - 1;
                else begin
                    rx_clk_counter <= BIT_PERIOD - 1;
                    if (rx_bit_index < DATA_WIDTH) begin
                        rx_shift_reg[rx_bit_index] <= rx_sync[1];
                        rx_bit_index <= rx_bit_index + 1;
                    end else begin
                        data_out <= rx_shift_reg;
                        data_out_valid <= 1;
                        rx_receiving <= 0;
                    end
                end
            end
        end
    end

endmodule

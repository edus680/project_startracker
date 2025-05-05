module uart_wrapper #(
    parameter CLK_FREQ = 100000000,
    parameter BAUD_RATE = 115200,
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire rx,
    output wire tx,
     output wire hb_led,
     output wire reset_led   
);

    wire [DATA_WIDTH-1:0] rx_data;
    wire rx_data_valid;
    reg  [DATA_WIDTH-1:0] tx_data;
    reg  tx_data_valid;
    wire tx_ready;
    wire busy;
    wire rx_output;
    
    heartbeat hb_inst (
        .clk(clk),          // sistem saati
        .rst_n(~reset),     // aktif düşük reset bekliyor
        .hb_led(hb_led)     // LED çıkışı (LD0)
    );
    
    
    
    
    uart #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE),
        .DATA_WIDTH(DATA_WIDTH)
    ) uart_inst (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data_in(tx_data),
        .data_in_valid(tx_data_valid),
        .data_out(rx_data),
        .data_out_valid(rx_data_valid),
        .tx(tx),
        .tx_ready(tx_ready),
        .busy(busy),
        .rx_output(rx_output)
    );

    ila_0 ila (
    .clk(clk),
   .probe0(rx_data),        // 8 bit
   .probe1(rx_data_valid),  // 1 bit
    .probe2(tx_data),        // 8 bit
   .probe3(tx_data_valid),  // 1 bit
    .probe4(tx_ready),       // 1 bit
    .probe5(busy),            // 1 bit
    .probe6(rx_output),  
    .probe7(reset) 
    );


assign reset_led = reset;  // reset sinyalini LED'e yönlendir

    reg [1:0] state;
    localparam IDLE = 2'd0, LOAD = 2'd1;

    always @(posedge clk) begin
        if (reset) begin
            tx_data <= 0;
            tx_data_valid <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    // tx_ready kontrolü çıkarıldı, rx_data_valid'e odaklanıldı
                    if (rx_data_valid) begin
                        tx_data <= rx_data + 8'd3;
                        tx_data_valid <= 1;
                        state <= LOAD;
                    end
                end
                LOAD: begin
                    tx_data_valid <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule

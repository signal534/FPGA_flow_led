module flow_led #(parameter M=24999999)  (
    input            sys_clk ,
    input            sys_rst_n,
    output reg [1:0] led  
);

reg [$clog2(M)-1:0] cnt;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) 
        cnt <= 0;
    else if (cnt<M) 
        cnt <= cnt+1;
    else
        cnt <= 0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) 
        led <= 2'b01;
    else if (cnt==M) 
        led <= {led[0],led[1]};
    else
        led <= led;
end

endmodule
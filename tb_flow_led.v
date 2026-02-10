`timescale 1ns / 1ps

module tb_flow_led();

// 参数定义
parameter CLK_PERIOD = 20;
parameter M_TEST = 24;  // 使用小参数加速仿真

// 信号定义
reg         sys_clk;
reg         sys_rst_n;
wire [3:0]  led;

// 实例化待测模块（使用小M值加速测试）
flow_led #(
    .M(M_TEST)
) u_flow_led (
    .sys_clk     (sys_clk),
    .sys_rst_n   (sys_rst_n),
    .led         (led)
);

// 时钟生成
initial begin
    sys_clk = 0;
    forever #(CLK_PERIOD/2) sys_clk = ~sys_clk;
end

// 测试激励
initial begin
    // 初始化
    sys_rst_n = 0;
    #100;
    
    // 释放复位
    sys_rst_n = 1;

    
    // 观察几个完整周期
    repeat (5 * M_TEST) @(posedge sys_clk);
    
    // 测试复位
    sys_rst_n = 0;
    #100;
    sys_rst_n = 1;
    
    // 继续观察
    repeat (5 * M_TEST) @(posedge sys_clk);
    
    // 结束
    $finish;
end
endmodule
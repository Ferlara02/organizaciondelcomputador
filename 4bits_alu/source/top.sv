`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2025 14:32:46
// Design Name: 
    module top(
        input mclk,
        input [15:0] sw,
        output [15:0] led,
        output [7:0] D0_seg, D1_seg,
        output [3:0] D0_a, D1_a
    );

    logic [28:0] cnt29 = 29'd0;
    logic [3:0] alu_result;
    logic zero_flag, carry_flag;
    
    alu alu(.a_in_0(sw[0]), .a_in_1(sw[1]), .a_in_2(sw[2]), .a_in_3(sw[3]),
            .b_in_0(sw[4]), .b_in_1(sw[5]), .b_in_2(sw[6]), .b_in_3(sw[7]),
            .alu_op_0(sw[8]), .alu_op_1(sw[9]), .alu_op_2(sw[10]),
            .alu_result_0(alu_result[0]), .alu_result_1(alu_result[1]), .alu_result_2(alu_result[2]), .alu_result_3(alu_result[3]),
            .zero_flag(zero_flag), .carry_flag(carry_flag));
    
    disp7seg_controller dispA(  .clk(cnt29[13]),
                                .bcd_dig({sw[11:8],4'b0000,4'b0000,alu_result[3:0]}),
                                .blank_dig(4'b0110),
                                .seg(D0_seg),
                                .dig_en(D0_a));
                                
    disp7seg_controller dispB(  .clk(cnt29[13]),
                                .bcd_dig({sw[3:0],4'b0000,4'b0000,sw[7:4]}),
                                .blank_dig(4'b0110),
                                .seg(D1_seg),
                                .dig_en(D1_a)  );

    always @(posedge mclk) cnt29 <= cnt29 + 1;
    
    assign led[7:0] = sw[7:0];
    assign led[8] = 1'b0;
    assign led[12:9] =  alu_result;
    assign led[13] = 1'b0;
    assign led[14] = zero_flag;
    assign led[15] = carry_flag;
    
    endmodule

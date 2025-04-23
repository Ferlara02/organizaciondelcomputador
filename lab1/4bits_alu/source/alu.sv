`timescale 1ns / 1ps

module alu(
    input a_in_0,
    input a_in_1,
    input a_in_2,
    input a_in_3,
    input b_in_0,
    input b_in_1,
    input b_in_2,
    input b_in_3,
    input alu_op_0,
    input alu_op_1,
    input alu_op_2,
    output alu_result_0,
    output alu_result_1,
    output alu_result_2,
    output alu_result_3,
    output zero_flag,
    output carry_flag
    );
    
    assign a_in_0 = alu_result_0;
    assign a_in_1 = alu_result_1;
    assign a_in_2 = alu_result_2;
    assign a_in_3 = alu_result_3;
       
    //------------------------- AND (000) -------------------------
    logic and0, and1, and2, and3;
    and_gate u_and_0 (.a(a_in_0), .b(b_in_0), .y(and0));
    and_gate u_and_1 (.a(a_in_1), .b(b_in_1), .y(and1));
    and_gate u_and_2 (.a(a_in_2), .b(b_in_2), .y(and2));
    and_gate u_and_3 (.a(a_in_3), .b(b_in_3), .y(and3));



    //------------------------- OR  (001) -------------------------
    logic or0, or1, or2, or3;
    
    or_gate u_or_0 (.a(a_in_0), .b(b_in_0), .y(or0));
    or_gate u_or_1 (.a(a_in_1), .b(b_in_1), .y(or1));
    or_gate u_or_2 (.a(a_in_2), .b(b_in_2), .y(or2));
    or_gate u_or_3 (.a(a_in_3), .b(b_in_3), .y(or3));


    //------------------------- ADD (010) -------------------------
    logic cero, add_0, carry_out_0, add_1, carry_out_1, add_2, carry_out_2, add_3, carry_out_3;
    assign cero = 0;
    
    adder_1bit u_adder_0 (.a(a_in_0), .b(b_in_0), .carry_in(cero), .add(add_0), .carry_out(carry_out_0));
    adder_1bit u_adder_1 (.a(a_in_1), .b(b_in_1), .carry_in(carry_out_0), .add(add_1), .carry_out(carry_out_1));
    adder_1bit u_adder_2 (.a(a_in_2), .b(b_in_2), .carry_in(carry_out_1), .add(add_2), .carry_out(carry_out_2));
    adder_1bit u_adder_3 (.a(a_in_3), .b(b_in_3), .carry_in(carry_out_2), .add(add_3), .carry_out(carry_out_3));

    

    //------------------------- SUB (110) -------------------------

    logic not_b_in_0, not_b_in_1, not_b_in_2, not_b_in_3;
    logic add_res_0, add_res_1, add_res_2, add_res_3, carry_out_res_0, carry_out_res_1, carry_out_res_2, carry_out_res_3;
    logic uno = 1;
    logic carry_out_d6, carry_out_res_10, carry_out_res_11, carry_out_res_12, add_res_10, add_res_11, add_res_12, add_res_13;

    not_gate b_not_0 (.a(b_in_0), .y(not_b_in_0));
    not_gate b_not_1 (.a(b_in_1), .y(not_b_in_1));
    not_gate b_not_2 (.a(b_in_2), .y(not_b_in_2));
    not_gate b_not_3 (.a(b_in_3), .y(not_b_in_3));

    adder_1bit res_b_0 (.a(not_b_in_0), .b(uno), .carry_in(cero), .add(add_res_0), .carry_out(carry_out_res_0));
    adder_1bit res_b_1 (.a(not_b_in_1), .b(cero), .carry_in(carry_out_res_0), .add(add_res_1), .carry_out(carry_out_res_1));
    adder_1bit res_b_2 (.a(not_b_in_2), .b(cero), .carry_in(carry_out_res_1), .add(add_res_2), .carry_out(carry_out_res_2));
    adder_1bit res_b_3 (.a(not_b_in_3), .b(cero), .carry_in(carry_out_res_2), .add(add_res_3), .carry_out(carry_out_res_3));

    adder_1bit res_0 (.a(a_in_0), .b(add_res_0), .carry_in(cero), .add(add_res_10), .carry_out(carry_out_res_10));
    adder_1bit res_1 (.a(a_in_1), .b(add_res_1), .carry_in(carry_out_res_10), .add(add_res_11), .carry_out(carry_out_res_11));
    adder_1bit res_2 (.a(a_in_2), .b(add_res_2), .carry_in(carry_out_res_11), .add(add_res_12), .carry_out(carry_out_res_12));
    adder_1bit res_3 (.a(a_in_3), .b(add_res_3), .carry_in(carry_out_res_12), .add(add_res_13), .carry_out(carry_out_d6));
    
    //------------------------- PIB (111) -------------------------
    logic d7_0 = b_in_0;
    logic d7_1 = b_in_1;
    logic d7_2 = b_in_2;
    logic d7_3 = b_in_3;
    //---------------------------- MUX ----------------------------


    mux8_1 alu_mux_0 (.d0(and0), .d1(or0), .d2(add_0), .d3(cero), .d4(cero), .d5(cero), .d6(add_res_10), .d7(d7_0), .sel_0(alu_op_0), .sel_1(alu_op_1), .sel_2(alu_op_2), .y(alu_result_0));
    mux8_1 alu_mux_1 (.d0(and1), .d1(or1), .d2(add_1), .d3(cero), .d4(cero), .d5(cero), .d6(add_res_11), .d7(d7_1), .sel_0(alu_op_0), .sel_1(alu_op_1), .sel_2(alu_op_2), .y(alu_result_1));
    mux8_1 alu_mux_2 (.d0(and2), .d1(or2), .d2(add_2), .d3(cero), .d4(cero), .d5(cero), .d6(add_res_12), .d7(d7_2), .sel_0(alu_op_0), .sel_1(alu_op_1), .sel_2(alu_op_2), .y(alu_result_2));
    mux8_1 alu_mux_3 (.d0(and3), .d1(or3), .d2(add_3), .d3(cero), .d4(cero), .d5(cero), .d6(add_res_13), .d7(d7_3), .sel_0(alu_op_0), .sel_1(alu_op_1), .sel_2(alu_op_2), .y(alu_result_3));

    //--------------------------- FLAGS ---------------------------

    mux8_1 cflag_mux (.d0(cero), .d1(cero), .d2(carry_out_3), .d3(cero), .d4(cero), .d5(cero), .d6(carry_out_d6), .d7(cero), .sel_0(alu_op_0), .sel_1(alu_op_1), .sel_2(alu_op_2), .y(carry_flag));

    //--------------------------- ZeroFLAG ---------------------------
    logic or_0_1, or_2_3, or_xx;

    or_gate u_or_01 (.a(alu_result_0), .b(alu_result_1), .y(or_0_1));
    or_gate u_or_23 (.a(alu_result_2), .b(alu_result_3), .y(or_2_3));

    or_gate u_or_xx (.a(or_0_1), .b(or_2_3), .y(or_xx));

    not_gate u_not_0 (.a(or_xx), .y(zero_flag));
    
    
endmodule

`timescale 1ns / 1ps


//add = a*¬b*¬carry_in + ¬a*¬b*carry_in + a*b*carry_in + ¬a*b*¬carry_in
//carry_out = a*carry_in + a*b + b*carry_in 

module adder_1bit(
    input logic a,
    input logic b,
    input logic carry_in,
    output logic add,
    output logic carry_out
);

    logic nota, notb, notc;
    logic t1, t2, t3, t4;

    // Inversores
    not_gate n1 (.a(a), .y(nota));
    not_gate n2 (.a(b), .y(notb));
    not_gate n3 (.a(carry_in), .y(notc));

    // Términos para add
    and_gate a1 (.a(a),    .b(notb),  .y(t1)); // a * ¬b
    and_gate a2 (.a(nota), .b(notb),  .y(t2)); // ¬a * ¬b
    and_gate a3 (.a(a),    .b(b),     .y(t3)); // a * b
    and_gate a4 (.a(nota), .b(b),     .y(t4)); // ¬a * b

    logic t1_and, t2_and, t3_and, t4_and;

    and_gate a5 (.a(t1), .b(notc), .y(t1_and)); // a*¬b*¬c
    and_gate a6 (.a(t2), .b(carry_in), .y(t2_and)); // ¬a*¬b*c
    and_gate a7 (.a(t3), .b(carry_in), .y(t3_and)); // a*b*c
    and_gate a8 (.a(t4), .b(notc), .y(t4_and)); // ¬a*b*¬c

    // Suma de los términos
    logic or1, or2, or3;

    or_gate o1 (.a(t1_and), .b(t2_and), .y(or1));
    or_gate o2 (.a(t3_and), .b(t4_and), .y(or2));
    or_gate o3 (.a(or1), .b(or2), .y(add));

    // carry_out = a*b + a*carry_in + b*carry_in
    logic ab, ac, bc, or4, or5;
    and_gate c1 (.a(a), .b(b), .y(ab));
    and_gate c2 (.a(a), .b(carry_in), .y(ac));
    and_gate c3 (.a(b), .b(carry_in), .y(bc));

    or_gate c4 (.a(ab), .b(ac), .y(or4));
    or_gate c5 (.a(or4), .b(bc), .y(carry_out));

endmodule



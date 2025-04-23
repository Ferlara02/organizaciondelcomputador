//-----------------------------------------------------------------------------
// 2-Input AND Gate
//-----------------------------------------------------------------------------
module and_gate (
    input  logic a, // Input A
    input  logic b, // Input B
    output logic y  // Output y = a AND b
);
    assign y = a & b;
endmodule

//-----------------------------------------------------------------------------
// 2-Input OR Gate
//-----------------------------------------------------------------------------
module or_gate (
    input  logic a, // Input A
    input  logic b, // Input B
    output logic y  // Output y = a OR b
);
    assign y = a | b;
endmodule

//-----------------------------------------------------------------------------
// NOT Gate (Inverter)
//-----------------------------------------------------------------------------
module not_gate (
    input  logic a, // Input A
    output logic y  // Output y = NOT a
);
    assign y = ~a;
endmodule

//-----------------------------------------------------------------------------
// 2-Input XOR Gate
//-----------------------------------------------------------------------------
module xor_gate (
    input  logic a, // Input A
    input  logic b, // Input B
    output logic y  // Output y = a XOR b
);
    assign y = a ^ b;
endmodule

//-----------------------------------------------------------------------------
// 2-to-1 Multiplexer (1-bit)
// Selects between two 1-bit inputs based on a select signal.
//-----------------------------------------------------------------------------
module mux2_1 (
    input  logic d0,  // Data input 0
    input  logic d1,  // Data input 1
    input  logic sel, // Select signal: 0 selects d0, 1 selects d1
    output logic y    // Output y
);
    // If sel is high (1), output d1; otherwise (0), output d0.
    assign y = sel ? d1 : d0;
endmodule

//-----------------------------------------------------------------------------
// 4-to-1 Multiplexer (1-bit)
// Selects between four 1-bit inputs based on a 2-bit select signal.
//-----------------------------------------------------------------------------
module mux4_1 (
    input  logic       d0,  // Data input 0 (selected when sel == 2'b00)
    input  logic       d1,  // Data input 1 (selected when sel == 2'b01)
    input  logic       d2,  // Data input 2 (selected when sel == 2'b10)
    input  logic       d3,  // Data input 3 (selected when sel == 2'b11)
    input  logic [1:0] sel, // 2-bit Select signal
    output logic       y    // Output y
);
    always_comb begin
        case (sel)
            2'b00:   y = d0;
            2'b01:   y = d1;
            2'b10:   y = d2;
            2'b11:   y = d3;
            default: y = 'x; // Assign 'x' for unknown select value
        endcase
    end
endmodule

//-----------------------------------------------------------------------------
// 8-to-1 Multiplexer (1-bit)
// Selects between eight 1-bit inputs based on a 3-bit select signal.
//-----------------------------------------------------------------------------
module mux8_1 (
    input  logic       d0,  // Data input 0 (selected when sel == 3'b000)
    input  logic       d1,  // Data input 1 (selected when sel == 3'b001)
    input  logic       d2,  // Data input 2 (selected when sel == 3'b010)
    input  logic       d3,  // Data input 3 (selected when sel == 3'b011)
    input  logic       d4,  // Data input 4 (selected when sel == 3'b100)
    input  logic       d5,  // Data input 5 (selected when sel == 3'b101)
    input  logic       d6,  // Data input 6 (selected when sel == 3'b110)
    input  logic       d7,  // Data input 7 (selected when sel == 3'b111)
    input  logic       sel_0, // 3-bit Select signal
    input  logic       sel_1, // 3-bit Select signal
    input  logic       sel_2, // 3-bit Select signal
    output logic       y    // Output y
);
    always_comb begin
        case ({sel_2,sel_1,sel_0})
            3'b000:  y = d0;
            3'b001:  y = d1;
            3'b010:  y = d2;
            3'b011:  y = d3;
            3'b100:  y = d4;
            3'b101:  y = d5;
            3'b110:  y = d6;
            3'b111:  y = d7;
            default: y = 'x; // Assign 'x' for unknown select value
        endcase
    end
endmodule

package lab;
module lab ();
    rule main;
        $display("Hello World!");
        for (UInt#(2) i = 0; i <= 1; i = i + 1) begin
            for (UInt#(2) j = 0; j <= 1; j = j + 1) begin
                for (UInt#(2) k = 0; k <= 1; k = k + 1) begin
                    $display("multiplelexer(%b,%b,%b)=%b", i, j, k, multiplelexer1(truncate(pack(i)), truncate(pack(j)), truncate(pack(k))));
                end
            end
        end

        $display("multiplelexer5(%b,%b,%b)=%b", 1'b1, 5'b01010, 5'b10101, multiplelexer5(1'b1, 5'b01010, 5'b10101));
        $display("multiplelexer_n(%b,%b,%b)=%b", 1'b1, 5'b01010, 5'b10101, multiplelexer_n(1'b1, 5'b01010, 5'b10101));
        $finish;
    endrule
endmodule

function Bit#(1) multiplelexer1(Bit#(1) sel, Bit#(1) a, Bit#(1) b);
    return (sel == 0) ? a : b;
endfunction


/// ** Exercise 1 (4 Points) Start
function Bit#(1) and1(Bit#(1) a, Bit#(1) b);
    return {a[0] & b[0]};
endfunction

function Bit#(1) or1(Bit#(1) a, Bit#(1) b);
    return {a[0] | b[0]};
endfunction

function Bit#(1) not1(Bit#(1) a);
    return ~a[0];
endfunction

function Bit#(1) multiplelexer1_gate(Bit#(1) sel, Bit#(1) a, Bit#(1) b);
    return or1(and1(not1(sel), a), and1(sel, b));
endfunction

// multiplelexer(00,00,00)=0
// multiplelexer(00,00,01)=0
// multiplelexer(00,01,00)=1
// multiplelexer(00,01,01)=1
// multiplelexer(01,00,00)=0
// multiplelexer(01,00,01)=1
// multiplelexer(01,01,00)=0
// multiplelexer(01,01,01)=1
/// ** Exercise 1 (4 Points) End


/// ** Exercise 2 (1 Points) Start
function Bit#(5) multiplelexer5(Bit#(1) sel, Bit#(5) a, Bit#(5) b);
    Bit#(5) c = 0;
    for (Integer i = 0; i < 5; i = i + 1) begin
        c[i] = multiplelexer1(sel, a[i], b[i]);
    end
    return c;
endfunction
/// ** Exercise 2 (1 Points) End


/// ** Exercise 3 (2 Points) Start
function Bit#(n) multiplelexer_n(Bit#(1) sel, Bit#(n) a, Bit#(n) b);
    Bit#(n) c = 0;
    for (Integer i = 0; i < valueOf(n); i = i + 1) begin
        c[i] = multiplelexer1(sel, a[i], b[i]);
    end
    return c;
endfunction
/// ** Exercise 3 (2 Points) End
endpackage
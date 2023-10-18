package in_class;
module in_class ();
    rule main;
        $display("Hello World!");
        $display("%b", addN(8'b11111111, 8'b00000001, 1'b0));
        $finish;
    endrule
endmodule


function Bit#(2) ha(Bit#(1) a, Bit#(1) b);
    Bit#(1) s = a ^ b;
    Bit#(1) c = a & b;
    return {c, s};
endfunction

function Bit#(2) fa(Bit#(1) a, Bit#(1) b, Bit#(1) c_in);
    Bit#(2) ab = ha(a, b);
    Bit#(2) abc = ha(ab[0], c_in);
    Bit#(1) c_out = ab[1] | abc[1];
    return {c_out, abc[0]};
endfunction

function Bit#(3) add(Bit#(2) x, Bit#(2) y, Bit#(1) c0);
    Bit#(2) s = 0;
    Bit#(3) c = 0;
    let cs0 = fa(x[0], y[0], c[0]);
    c[1] = cs0[1];
    s[0] = cs0[0];
    let cs1 = fa(x[1], y[1], c[1]);
    c[2] = cs1[1];
    s[1] = cs1[0];

    return {c[2], s};
endfunction

function Bit#(TAdd#(w,1)) addN(Bit#(w) x, Bit#(w) y, Bit#(1) c0);
    Bit#(w) s;
    Bit#(TAdd#(w,1)) c = 0;
    c[0] = c0;
    let valw = valueOf(w);

    for (Integer i = 0; i < valw; i = i + 1)
    begin
        let cs = fa(x[i], y[i], c[i]);
        c[i + 1] = cs[1];
        s[i] = cs[0];
    end 
    
    return {c[valw], s};
endfunction

endpackage
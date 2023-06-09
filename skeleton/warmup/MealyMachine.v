module MealyPattern(
	input        clock,
	input        i,
	output [1:0] o
);

//Unique binary representation for each state:
reg [1:0]  q;
reg [1:0]  t;

initial begin
	q = 2'b00;
	t = 2'b00;
end

always @(posedge clock) begin  // update at rising clock edge
	q[0] <= q[1];
	q[1] <= i;
end

always @* begin  // change the output combinatorially -> doe not depend on clock edge
	if (q[0] == 1 && q[1] == 0 && i==1) begin
		t = 2'b01;
	end
	else 
		if (q[0] == 0 && q[1] == 1 && i==0) begin
		t = 2'b10;
	end
		else 
		t = 2'b00;
end

assign o = t;

endmodule

module MealyPatternTestbench();

	reg i;
	reg clock;
	wire  [1:0] o;

	MealyPattern machine(.clock(clock), .i(i), .o(o));

	initial begin
		i = 0 ;
		clock = 0 ;
	end

	always
		#1
		clock = !clock;
	
	initial begin
		#2
		i = 1;
		#2
		i = 1;
		#2
		i = 0;
		#2
		i = 1;
		#2
		i = 0;
		#2
		i = 1;
		#2
		i = 0;
		#2
		i = 1;
		#2
		i = 1;
	end

	initial begin
		$dumpfile ("mealy.vcd");
		$dumpvars ;
	end

	initial
		#20 $finish;


	//  011

endmodule


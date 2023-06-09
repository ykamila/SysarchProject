module Division(
	input         clock,
	input         start,
	input  [31:0] a, //divident
	input  [31:0] b, //divisor
	output [31:0] q, //quotient
	output [31:0] r  //remainder
);
	
	reg [31:0] rem; // remainder -> r
	reg [31:0] div; // divisor -> b
	reg [31:0] dit; // divident -> a
	reg [31:0] count; // counter for clock-cycles



	initial
	begin
	count  = 32'b0;
	end

	always @(posedge clock) begin
		if (start==1) begin
			div <= b;
			rem <= 32'b0;
			dit <= a;
			count <= 32'b1;//set counter 
		end

		if (count >= 1 && count <= 32) begin
			count <= count +1;
			//rem2 <= (rem << 1);  R’ = 2 * R

			if (((rem << 1)+(dit >> 31)) < b) begin
				rem <= (rem << 1) + (dit >> 31);
				dit <= (dit << 1);
			end 
			else begin
				rem <= ((rem << 1) + (dit >> 31)) - div;
				dit <= (dit << 1)+1;
			end
	
		end
	end

	assign q = dit;
	assign r = rem;

endmodule


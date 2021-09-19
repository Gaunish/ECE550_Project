module mux_2(input in0, input in1, input select, output out);
	assign out = select ? in1 : in0;
endmodule
	

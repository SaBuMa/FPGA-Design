//***************** Module = Inputs Outputs *****************--
//***********************************************************--
module my_dff                	

(
    input clk,    // Clock
    input rst,    // Reset
    input ena,    // Enable
    input d,		// Parallel Output 
	 output reg q	// Parallel Output 	
); 

//**************** Parameterized description ****************--
//***********************************************************--	
always @ (posedge clk or posedge rst) 
begin
	if (rst)
		q <= 0;
	else if (clk)
		if (ena)
			q <= d;
end

endmodule
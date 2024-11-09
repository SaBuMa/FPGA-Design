# [Verilog](Verilog_Files)
## Verilog Code
```
//******************* Full Adder One Bit ********************--
//***********************************************************--

//**************** module = Inputs Outputs ******************--
//***********************************************************--
module FAOB
 (	input A_0,B_0,Cin_0,
	output reg Q_0, Cout_0
 );

//******************* Auxiliary cables **********************--
//***********************************************************--
wire e1,e2,e3;

assign e1 = A_0 ^ B_0;
assign e2 = A_0 & B_0;
assign e3 = e1 & Cin_0;

always @ (e1, e2, e3, Cin_0)
	begin
	 Q_0 = e1 ^ Cin_0;
	 Cout_0 = e3 | e2;
	end

//************* Compact description of Adder ****************--
//***********************************************************--
// For the compact descriptions the outputs of the module
// must be of "net" type, thus it is reflected in the code
// changing the outputs Type.

//module FAOB
// (	input A_0,B_0,Cin_0,
//	output Q_0, Cout_0
// );
// 
//assign {Cout_0, Q_0} = A_0 + B_0 + Cin_0;

endmodule 
```
## Verilog RTL
This first image represent the Full Adder One Bit in a Gate Level description
<p align="center">
<img src="../FAOB_Img/RTL_GateLevel_Verilog.png" alt="RTL GateLevel Verilog" width="500" border= 2px black;/>
</p>
<p align="center">
    <b>
       RTL Gate Level
    </b>
</p>

Now using describing the **"Full Adder One Bit"** in a compact way using Verilog, the next image is the output RTL.
<p align="center">
<img src="../FAOB_Img/RTL_SIMPLIFIED_Verilog.png" alt="RTL Siplified Verilog" width="500" border= 2px black;/>  
</p>
<p align="center">
    <b>
       RTL Compact Description
    </b>
</p>

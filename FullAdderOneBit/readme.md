# Full Adder 1 Bit
For this scenario, a **Full Adder** is being implemented using **logic gates**. Then through the use of **Quartus**, the circuit is going to be coded both in **VHDL** and **Verilog**.

Furthermore, using Quartus one can check that the VHDL or Verilog code implement does in fact recreate the circuit in question.

## Block Diagram and Truth Table
<p align="Center">
<img src="FAOB_Img/FullAdderOneBit.png" alt="Gate Level" width="350" /> 
<img src="FAOB_Img/FullAdderOneBitTruthTable.png" alt="TruthTable" width="250" />  
</p>

## Hardware used
<p align="center">
    <b>  
        FPGA DE10-Lite  
    </b>
</p>
<p align="center">
<img src="FAOB_Img/FPGA1.JPG" alt="FPGA BOX" width="300"/> 
<img src="FAOB_Img/FPGA2.JPG" alt="FPGA Board" width="300"/> 
</p>

## Software used
<p>
    <b>  
        Design Software  
    </b>
</p>
<p align ="center" >
    <i>
         Quartus --> Design / Synthesis / FPGA Support.
    </i>
</p>
<p>
    <b>  
        Simulation Software
    </b>
</p>
<p align="center">
  <i>
        Mentor Graphics Questa (Modelsim) --> Functional Timing.
  </i>
</p>
<p align="center">
<img src="FAOB_Img/Quartus.JPG" alt="QuartusPrime" width="300"/> 
<img src="FAOB_Img/Questa.png" alt="Questa" width="170"/>  
</p>

## [VHDL](VHDL_Files)
## [Verilog](Verilog_Files)
## Board Configuration
### Pin assignment

For this project the inputs of the Full Adder One Bit are going to be the 
**Switches** located in the lower half of the Development Board.

Furthermore to represent the Outputs of the created circuit the red **LEDs**
also present in the board are going to be used.
<p align="center">
<img src="FAOB_Img/Switches.png" alt="Switches" width="300"/>  
<img src="FAOB_Img/LEDs.png" alt="LEDs" width="283"/>  
</p>

To proceed with the assignment of the **Switches** and **LEDs** to the Inputs and
Outputs. First it is needed to perform a full compilation of the project and
have the proper devices "FPGA" selected. 

After compilation, refer to the **User Manual** of the FPGA Board to determine
the pins that are hard-wire from the **ALTERA MAX 10 FPGA** to the **Switches** and **LEDs** on the board.
(The User Manual is shown below )

<p align="center">
<img src="FAOB_Img/LEDs_pag28.png" alt="UserManual" width="250"border= 2px black;/>    
<img src="FAOB_Img/Switches_pag27.png" alt="UserManual" width="250"border= 2px black;/>    
</p>

Finally after determining the pins for the Switches and LEDs, proceed to 
choose the Switches SW2, SW1, SW0 (PIN_D12, PIN_C11 and PIN_C10 respectively)
for the Inputs A_0, B_0 and Cin_0 respectively. Then for the LEDs choose
LEDR1 and LEDR0 (PIN_A9 and PIN_A8) fro the Outputs Q_0 and Cout_0 respectively.
The Pin Planner configuration is shown below

<p align="center">
<img src="FAOB_Img/PinPlanner.png" alt="PinPlanner" width="350"border= 2px black;/>    
</p>
<p align="center">
<img src="FAOB_Img/PinPlanner_Zoom.png" alt="PinPlanner_Zoom" width="600"border= 2px black;/>  
</p>

## Board Testing

<p align="center">
<img src="FAOB_Img/FAOB_gif.gif" alt="Working .gif" width="500">
</p>


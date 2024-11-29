# Binary Counter
For this scenario, an **Binary Counter** is being implemented using **logic gates**, **"instantiation"** and the **"Generate Block"**. Then through the use of **Quartus**, the circuit is going to be coded both in **VHDL** and **Verilog** languages. With the use of Quartus one can check the VHDL or Verilog code implementation does in fact recreate the circuit in question looking at the **RTL model** created by Quartus.

## Block Diagram and Truth Table
<p align="Center">
    <kbd>
        <img src="BinCounter_Img/BinCounter_Block.png" alt="Block Dia" width="380" />
    </kbd>
</p>

## Hardware used
<p align="center">
    <b>  
        FPGA DE10-Lite  
    </b>
</p>
<p align="center">
    <kbd>
        <img src="../FPGA_PrjImg/FPGA1.JPG" alt="FPGA BOX" width="250"/> 
    </kbd>
    <kbd>
        <img src="../FPGA_PrjImg/FPGA2.JPG" alt="FPGA Board" width="250"/> 
    </kbd>
</p>

## Software used
<p>
    <b>  
        Design Software  
    </b>
</p>
<p align="center">
    <kbd>
        <img src="../FPGA_PrjImg/Quartus.png" alt="QuartusPrime" width="100"/> 
    </kbd>
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
    <kbd>
        <img src="../FPGA_PrjImg/Questa.png" alt="Questa" width="100"/>  
    </kbd>
</p>
<p align="center">
  <i>
        Mentor Graphics Questa (Modelsim) --> Functional Timing.
  </i>
</p>

## [VHDL](VHDL_Files)
### VHDL Code
For the code, **VHDL 2008** was used in order to allow comments using "--"  
```

```
[comment]: <> (To make a reference to a parent folder, used when the images are within a parent folder od the Readme.md file one must use ".." as represented below)
### VHDL RTL
**1.** This first image represent the **Binary Counter** in a Gate Level description using **Instantiation**
<p align="center">
    <kbd>
        <img src="BinCounter_Img/BinCounter_VHDL_GateLevel.png" alt="BinCounter_VHDL_GateLevel" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL Gate Level Instantiation
    </b>
</p>

**2.** This second image represent the **Binary Counter** in a Gate Level description using the **Generate Block**
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_VHDL_Generate.png" alt="CNB_VHDL_Generate" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL Gate Level Generate Block
    </b>
</p>

**3.** Finally describing the **Binary Counter** in a compact way
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_VHDL_Compact.png" alt="CNB_VHDL_Compact" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Compact Description
    </b>
</p>

## [Verilog](Verilog_Files)
## Verilog Code
```

```
## Verilog RTL
**1.** This first image represent the **Binary Counter** in a Gate Level description using **Instantiation**
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_Verilog_GateLevel.png" alt="CNB_Verilog_GateLevel" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL Gate Level Instantiation
    </b>
</p>

**2.** This second image represent the **Binary Counter** in a Gate Level description using the **Generate Block**
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_Verilog_Generate.png" alt="CNB_Verilog_Generate" width="500"/>
    </kbd>
</p>
<p align="center">
    <b>
       RTL Gate Level Generate Block
    </b>
</p>

**3.** Finally describing the **Binary Counter** in a compact way
<p align="center">
    <kbd>
        <img src="CNB_Img/CNB_Verilog_Compact.png" alt="CNB_Verilog_Compact" width="500"/>  
    </kbd>
</p>
<p align="center">
    <b>
       RTL Compact Description
    </b>
</p>

## Board Configuration
### Pin assignment

For this project, the inputs of the Full Adder One Bit are going to be the 
**Switches** located in the lower half of the Development Board.

To represent the Outputs of the Full Adder circuit, the red **LEDs**
also present in the board are going to be used.

<p align="center">
    <kbd>
        <img src="../FPGA_PrjImg/Switches.png" alt="Switches" width="250"/>  
    </kbd>
    <kbd>
        <img src="../FPGA_PrjImg/LEDs.png" alt="LEDs" width="235"/>  
    </kbd>
</p>

To proceed with the assignment of the **Switches** and **LEDs** to the Inputs and
Outputs of the Full Adder circuit inside Quartus. First it is needed to perform a full compilation of the project and
have the proper device "**FPGA/DevBoard**" selected. 

After compilation, refer to the **User Manual** of the FPGA Board to determine
the pins that are hard-wire from the **ALTERA MAX 10 FPGA** to the **Switches** and **LEDs** on the board.

(The User Manual is shown below )

<p align="center">
    <kbd>
        <img src="../FPGA_PrjImg/LEDs_pag28.png" alt="UserManual" width="250"/>
    </kbd>
    <kbd>    
        <img src="../FPGA_PrjImg/Switches_pag27.png" alt="UserManual" width="250"/>
    </kbd>    
</p>

Now, for the next stage, proceed to choose:
* The Switches **SW7 to SW4** for Inputs **A_N**, Switches **SW3 to SW0** for Inputs **B_N**.

* Then for the LEDs choose **LEDR9** for Output **AlwrB_N**, LED **LEDR4** for Output **AeqB_N** and, LED **LEDR0** for Output **AgrtB_N**.

These pins are declared in the Pin PLanner of Quartus:  
***Assignments-->Pin Planner***  
The Pin Planner configuration is shown below

<p align="center">
    <kbd>
        <img src="CNB_Img/PinPlanner.png" alt="PinPlanner" width="550"/> 
    </kbd>   
    <kbd>
        <img src="CNB_Img/PinPlanner_Zoom.png" alt="PinPlannerZoom" width="550"/> 
    </kbd>   
</p>

After assigning the Pins for the Inputs and Outputs, perform ***"I/O Assignment Analysis"*** to check for error in the assignments. For the last step perform a Full compilation of all the circuit before uploading it to the board. 

## Board Testing
After doing all the preparation work described before, go to:
***Tools-->Programmer***.  
To program the Development Board with the **.sof** file that has been created inside the root folder of the project.

<p align="center">
    <img src="CNB_Img//FPGAWorking.gif" alt="Working .gif" width="500">
</p>

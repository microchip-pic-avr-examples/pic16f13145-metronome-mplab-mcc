<!-- Please do not change this html logo with link -->

<a href="https://www.microchip.com" rel="nofollow"><img src="images/microchip.png" alt="MCHP" width="300"/></a>

# Metronome Waveform Generator — Use Case for CLB using the PIC16F13145 Microcontroller with MCC Melody

This repository provides an MPLAB® X project for interfacing the Configurable Logic Block (CLB) and a Switec Stepper motor. By the end, you will be able to drive a stepper motor to re-create a metronome using the CLB peripheral.

The CLB peripheral is a collection of logic elements that can be programmed to perform a wide variety of digital logic functions. The logic function may be completely combinatorial, sequential, or a combination of the two, enabling users to incorporate hardware-based custom logic into their applications.


## Related Documentation

More details and code examples on the PIC16F13145 can be found at the following links:

- [PIC16F13145 Product Page](https://www.microchip.com/en-us/product/PIC16F13145?utm_source=GitHub&utm_medium=TextLink&utm_campaign=MCU8_MMTCha_PIC16F13145&utm_content=pic16f13145-metronome-mplab-mcc&utm_bu=MCU08)
- [PIC16F13145 Code Examples on Discover](https://mplab-discover.microchip.com/v2?dsl=PIC16F13145)
- [PIC16F13145 Code Examples on GitHub](https://github.com/microchip-pic-avr-examples/?q=PIC16F13145)
- [X27.168 Switec Motor Datasheet](https://guy.carpenter.id.au/gaugette/resources/switec/X25_xxx_01_SP_E-1.pdf)


## Software Used

- [MPLAB® X IDE v6.15 or newer](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide?utm_source=GitHub&utm_medium=TextLink&utm_campaign=MCU8_MMTCha_PIC16F13145&utm_content=pic16f13145-metronome-mplab-mcc&utm_bu=MCU08)
- [MPLAB XC8 v2.45 or newer](https://www.microchip.com/en-us/tools-resources/develop/mplab-xc-compilers?utm_source=GitHub&utm_medium=TextLink&utm_campaign=MCU8_MMTCha_PIC16F13145&utm_content=pic16f13145-metronome-mplab-mcc&utm_bu=MCU08)
- [PIC16F1xxxx_DFP v1.23.382 or newer](https://packs.download.microchip.com/)

## Hardware Used

- The [PIC16F13145 Curiosity Nano Development board](https://www.microchip.com/en-us/development-tool/EV06M52A?utm_source=GitHub&utm_medium=TextLink&utm_campaign=MCU8_MMTCha_PIC16F13145&utm_content=pic16f13145-metronome-mplab-mcc&utm_bu=MCU08) is used as a test platform:
    <br><img src="images/pic16f13145-cnano.png" width="800">

- x27.168 Switec Motor:
    <br><img src="images/x27-168-switec-motor.png" width="400">

- Logic Analyzer



## Operation

To program the Curiosity Nano board with this MPLAB X project, follow the steps provided in the [How to Program the Curiosity Nano Board](#how-to-program-the-curiosity-nano-board) chapter.<br><br>

## Concept

This example demonstrates the capabilities of the CLB, a Core Independent Peripheral (CIP), that can generate the waveforms that drive a Switec Stepper motor as a metronome.

The signals needed to drive the Switec stepper motor in both directions are shown in image below.
<br><img src="images/motor_waveforms.png" width="800">

A complete rotation (360°) of the rotor corresponds to six clock cycles and corresponds to 2° rotation of the shaft because the Switec motor has a gear train with a reduction ratio of 1/180. The generated waveform have a frequency six times lower than the CLB clock frequency.

For the counterclockwise movement, the second signal can be derived from the first one by using a one clock delay and a NOT gate. Using the same operations, the third signal can be obtain from the second one.
<br>
The signals that drive the motor clockwise can be obtained from the signals that drive it counterclockwise, but generated in the opposite direction. This gives us a bidirectional shift register. The figure below shows the implemented solution for waveforms generation.

<br><img src="images/mcc_clb_circuit.png" width="800">

For the metronome functionality, a 6-bit counter is used to determine the number of steps that the metronome does in each direction. The enable signal is obtained from an AND operation between the first signal and one of the other signals that are chosen using a multiplexor. The most significat bit (MSB) of the counter is used to determine the direction of the bidirectional shift register. Using this implementation the motor will run 32 complete steps in each direction. The result will be that the metronome will have an oscillation of 16 steps in each direction.

The implementation of the counter is shown in the below images.
<br><img src="images/mcc_clb_6bit_counter.png" width="800">
<br><img src="images/mcc_clb_t_flip_flop.png" width="800">

<br>
When the application starts, the shaft of the motor is set to an initial position, so that the oscillation always starts from a fixed position that is symmetrical to the center of the dial. A multiplexor is used to select the input for the bidirectional shift register between the counter output and a CLB Software Input Register (CLBSWIN). The CLBSWIN1 is used to select between METRONOME and FREE_RUN mode, in which the motor will run contionously in one direction. The CLBSWIN0 is used to select between clockwise and counterclockwise movement in FREE_RUN mode.

<br>

| **SWIN1** | **SWIN0** |  **Mode** |   **Direction**  |
|:---------:|:---------:|:---------:|:----------------:|
|     0     |     0     |  FREE_RUN |     CLOCKWISE    |
|     0     |     1     |  FREE_RUN | COUNTERCLOCKWISE |
|     1     |     0     | METRONOME |         -        |
|     1     |     1     | METRONOME |         -        |

<br>
The frequency of the metronome is set by the clock input of the CLB. The Switec Stepper motor used can run at a frequency between 200 and 600 Hz. This frequency is obtain by using TMR0 overflow as a clock input for the CLB. For this application the frequency is set to 400 Hz.

For the FREE_RUN mode, used to set the initial position, TMR1 is used to count the steps that the motor does in one direction. This functionality is obtain by using TMR0 overflow as a clock input for TMR1, meaning that 6 counts of the TMR1 represents 1 full step of the motor, composed from 6 partial steps.

<br>

The figure below shows the waveforms that drives the motor in both directions.
<br><img src="images/waveforms.png" width="800">

## Setup 

The following peripheral and clock configurations are set up using MPLAB® Code Configurator (MCC) Melody for the PIC16F13145:

1. Configurations Bits:
    - CONFIG1:
        - External Oscillator mode selection bits: Oscillator not enabled
        - Power-up default value for COSC bits: HFINTOSC (1MHz)
        <br><img src="images/mcc_config_bits_1.png" width="400">
    - CONFIG2:
        - Brown-out reset enable bits: Brown-out reset disabled
        <br><img src="images/mcc_config_bits_2.png" width="400">
    - CONFIG3:
        - WDT operating mode: WDT Disabled, SEN is ignored
        <br><img src="images/mcc_config_bits_3.png" width="400">

2. Clock Control:
    - Clock Source: HFINTOSC
    - HF Internal Clock: 4_MHz
    - Clock Divider: 1
    <br><img src="images/mcc_clock_control.png" width="400">

3. CLB1:
    - Enable CLB: Enabled
    - Clock Selection: Timer0_Overflow
    - Clock Divider: Divide clock source by 1
    <br><img src="images/mcc_clb.png" width="400"> 

4. TMR0:
    - Enable Timer: Disabled
    - Clock Prescaler: 1:16
    - Clock Postcaler: 1:2
    - Timer Mode: 8-bit
    - Clock Source: F<sub>OSC</sub>/4 
    - Enable Syncronisation: Enabled
    - Requested Period (s): 0.0025
    <br><img src="images/mcc_tmr0.png" width="400">

5. TMR1:
    - Enable Timer: Disabled
    - Clock Selection: TMR0_Overflow
    - Prescaler: 1:1
    - Enable Period Count Editor: Enabled
    - Period Count: 0
    - TMR Interrupt Enable: Enable
    <br><img src="images/mcc_tmr1.png" width="400">  

6. CRC:
    - Auto-configured by CLB

7. NVM:
    - Auto-configured by CLB

8. Pin Grid View:
    - CLBPPSOUT0: RB6 (Contact 1)
    - CLBPPSOUT1: RB5 (Contact 2, 3)
    - CLBPPSOUT2: RB4 (Contact 4)
    - CLBPPSOUT3: RC2 (Used to visualize the signal that change direction)
    <br><img src="images/mcc_pin_grid_view.png" width="600"> 

<br>

## Demo

<br><img src="images/demo.gif" width="600"> 

<br>

## Summary

This example demonstrates the capabilities of the CLB, a  CIP that can generate the waveforms that drive a Switec Stepper motor as a metronome.
<br>

##  How to Program the Curiosity Nano Board

This chapter demonstrates how to use the MPLAB X IDE to program a PIC® device with an Example_Project.X. This is applicable to other projects.

1.  Connect the board to the PC.

2.  Open the Example_Project.X project in MPLAB X IDE.

3.  Set the Example_Project.X project as main project.
    <br>Right click the project in the **Projects** tab and click **Set as Main Project**.
    <br><img src="images/Program_Set_as_Main_Project.png" width="600">

4.  Clean and build the Example_Project.X project.
    <br>Right click the **Example_Project.X** project and select **Clean and Build**.
    <br><img src="images/Program_Clean_and_Build.png" width="600">

5.  Select **PICxxxxx Curiosity Nano** in the Connected Hardware Tool section of the project settings:
    <br>Right click the project and click **Properties**.
    <br>Click the arrow under the Connected Hardware Tool.
    <br>Select **PICxxxxx Curiosity Nano** (click the **SN**), click **Apply** and then click **OK**:
    <br><img src="images/Program_Tool_Selection.png" width="600">

6.  Program the project to the board.
    <br>Right click the project and click **Make and Program Device**.
    <br><img src="images/Program_Make_and_Program_Device.png" width="600">

<br>

- - - 
## Menu
- [Back to Top](#metronome-waveform-generator--use-case-for-clb-using-the-pic16f13145-microcontroller-with-mcc-melody)
- [Back to Related Documentation](#related-documentation)
- [Back to Software Used](#software-used)
- [Back to Hardware Used](#hardware-used)
- [Back to Operation](#operation)
- [Back to Concept](#concept)
- [Back to Setup](#setup)
- [Back to Demo](#demo)
- [Back to Summary](#summary)
- [Back to How to Program the Curiosity Nano Board](#how-to-program-the-curiosity-nano-board)
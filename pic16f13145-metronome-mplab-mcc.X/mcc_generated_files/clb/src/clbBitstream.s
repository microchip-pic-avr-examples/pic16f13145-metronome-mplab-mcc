/**
 *  @file clbBitstream.s
 *
 *  @brief CLB bitstream data for the PIC16F13145 device family
 *
 **/
/*
© [2026] Microchip Technology Inc. and its subsidiaries.

    Subject to your compliance with these terms, you may use Microchip 
    software and any derivatives exclusively with Microchip products. 
    You are responsible for complying with 3rd party license terms  
    applicable to your use of 3rd party software (including open source  
    software) that may accompany Microchip software. SOFTWARE IS ?AS IS.? 
    NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS 
    SOFTWARE, INCLUDING ANY IMPLIED WARRANTIES OF NON-INFRINGEMENT,  
    MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT 
    WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY 
    KIND WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF 
    MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE 
    FORESEEABLE. TO THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP?S 
    TOTAL LIABILITY ON ALL CLAIMS RELATED TO THE SOFTWARE WILL NOT 
    EXCEED AMOUNT OF FEES, IF ANY, YOU PAID DIRECTLY TO MICROCHIP FOR 
    THIS SOFTWARE.
*/

/*
    The bitstream data can be accesed from C source code by referencing the 'start_clb_config' symbol as such:

    extern uint16_t start_clb_config;
    uint16_t clbStartAddress = (uint16_t) &start_clb_config;

    IMPORTANT: You must always use the address of these symbols and not the value of the symbols themselves.
               If values instead of addresses are used, the linker will silently generate incorrect code.

    uint16_t clbStartAddress = start_clb_config; // This is incorrect!

    NOTE: This module requires C preprocessing.
          This can be enabled via the command line option: -xassembler-with-cpp
*/


#include <xc.inc>

#if !( defined(_16F13113) || defined(_16F13114) || defined(_16F13115) || \
       defined(_16F13123) || defined(_16F13124) || defined(_16F13125) || \
       defined(_16F13143) || defined(_16F13144) || defined(_16F13145) )

    #error This assembly file is intended to be used only with the PIC16F13145 device family!

#endif

GLOBAL  _start_clb_config
GLOBAL  _end_clb_config

PSECT  clb_config,global,class=STRCODE,delta=2,noexec,optim=

_start_clb_config:
    DW  0x03E1
    DW  0x3C1F
    DW  0x21F0
    DW  0x03E4
    DW  0x0C73
    DW  0x001F
    DW  0x03E1
    DW  0x3E1F
    DW  0x33F8
    DW  0x119F
    DW  0x19FC
    DW  0x3F86
    DW  0x33EC
    DW  0x3FFF
    DW  0x03FE
    DW  0x0C1F
    DW  0x03E1
    DW  0x3C1F
    DW  0x21F0
    DW  0x3E1F
    DW  0x03F0
    DW  0x3E1F
    DW  0x3FE0
    DW  0x01FF
    DW  0x33F8
    DW  0x1000
    DW  0x3E00
    DW  0x0903
    DW  0x3C97
    DW  0x0584
    DW  0x1878
    DW  0x12DF
    DW  0x03E1
    DW  0x3DFF
    DW  0x1E36
    DW  0x08C5
    DW  0x1BF6
    DW  0x3E0D
    DW  0x2090
    DW  0x0501
    DW  0x03E1
    DW  0x3DFF
    DW  0x1E0A
    DW  0x035F
    DW  0x2BEA
    DW  0x3F4C
    DW  0x0058
    DW  0x0C06
    DW  0x208E
    DW  0x1502
    DW  0x2FFC
    DW  0x3F81
    DW  0x33EC
    DW  0x3E1F
    DW  0x03E0
    DW  0x1DE4
    DW  0x03E0
    DW  0x1406
    DW  0x1850
    DW  0x09E5
    DW  0x20D7
    DW  0x0A04
    DW  0x3FF4
    DW  0x1EA4
    DW  0x158A
    DW  0x087F
    DW  0x0660
    DW  0x18A2
    DW  0x0003
    DW  0x0D9F
    DW  0x3059
    DW  0x3D9F
    DW  0x142A
    DW  0x1003
    DW  0x3E00
    DW  0x3FFF
    DW  0x00AF
    DW  0x3E1F
    DW  0x3FE0
    DW  0x09FF
    DW  0x29B5
    DW  0x3D5F
    DW  0x15F0
    DW  0x3E1F
    DW  0x03F0
    DW  0x3F1F
    DW  0x23F1
    DW  0x3D1F
    DW  0x23F1
    DW  0x3D1F
    DW  0x11F8
    DW  0x3F1F
    DW  0x23E8
    DW  0x3F1F
    DW  0x23F1
    DW  0x3D1F
    DW  0x00E0
    DW  0x3000
    DW  0x0000
    DW  0x0000
    DW  0x3800
    DW  0x0000
_end_clb_config:

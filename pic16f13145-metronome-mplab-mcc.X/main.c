 /*
 * MAIN Generated Driver File
 * 
 * @file main.c
 * 
 * @defgroup main MAIN
 * 
 * @brief This is the generated driver implementation file for the MAIN driver.
 *
 * @version MAIN Driver Version 1.0.0
*/

/*
© [2024] Microchip Technology Inc. and its subsidiaries.

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
#include "mcc_generated_files/system/system.h"

#define MAX_STEPS_CLOCKWISE                 180
#define STEPS_TO_INITIAL_POSITION           106

#define RUN_COUNTERCLOCKWISE()              {CLBSWINLbits.CLBSWIN0 = 1;}
#define RUN_CLOCKWISE()                     {CLBSWINLbits.CLBSWIN0 = 0;}
#define MODE_METRONOME()                    {CLBSWINLbits.CLBSWIN1 = 1;}
#define MODE_FREE_RUN()                     {CLBSWINLbits.CLBSWIN1 = 0;}
#define TIMER_RELOAD_VALUE(STEPS_NUMBER)    (0xFFFF - 6 * STEPS_NUMBER)

bool TMR1_Overflow = false;

void Motor_Run(uint16_t number_of_steps) 
{
    TMR1_Write(TIMER_RELOAD_VALUE(number_of_steps));
    
    TMR1_Start();
    
    Timer0_Start();
    
    while(!TMR1_Overflow){
        ;
    }
    
    TMR1_Overflow = false;
    
    Timer0_Stop();
    
    TMR1_Stop();
}

void Run_Completely_Clockwise(void)
{
    RUN_CLOCKWISE();
    
    MODE_FREE_RUN();
    
    Motor_Run(MAX_STEPS_CLOCKWISE);
}

void Run_In_Start_Position(void)
{
    RUN_COUNTERCLOCKWISE();
    
    MODE_FREE_RUN();
    
    Motor_Run(STEPS_TO_INITIAL_POSITION);
}

void Set_Initial_Position(void)
{
    Run_Completely_Clockwise();
    
    __delay_ms(100);
    
    Run_In_Start_Position();
    
    __delay_ms(100);
}

void Start_Metronome(void)
{
    MODE_METRONOME();
    
    Timer0_Start();
}

void TMR1_UserOverflowCallback(void)
{
    TMR1_Overflow = true;
}

/*
    Main application
*/

int main(void)
{
    SYSTEM_Initialize();

    // If using interrupts in PIC18 High/Low Priority Mode you need to enable the Global High and Low Interrupts 
    // If using interrupts in PIC Mid-Range Compatibility Mode you need to enable the Global and Peripheral Interrupts 
    // Use the following macros to: 

    // Enable the Global Interrupts 
    INTERRUPT_GlobalInterruptEnable(); 

    // Disable the Global Interrupts 
    //INTERRUPT_GlobalInterruptDisable(); 

    // Enable the Peripheral Interrupts 
    INTERRUPT_PeripheralInterruptEnable(); 

    // Disable the Peripheral Interrupts 
    //INTERRUPT_PeripheralInterruptDisable(); 

    TMR1_OverflowCallbackRegister(TMR1_UserOverflowCallback);
    
    Set_Initial_Position();
    
    Start_Metronome();
    
    while(1)
    {
        ;
    }    
}
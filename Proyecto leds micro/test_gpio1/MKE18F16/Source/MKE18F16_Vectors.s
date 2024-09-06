/*********************************************************************
*                    SEGGER Microcontroller GmbH                     *
*                        The Embedded Experts                        *
**********************************************************************
*                                                                    *
*            (c) 2014 - 2022 SEGGER Microcontroller GmbH             *
*                                                                    *
*       www.segger.com     Support: support@segger.com               *
*                                                                    *
**********************************************************************
*                                                                    *
* All rights reserved.                                               *
*                                                                    *
* Redistribution and use in source and binary forms, with or         *
* without modification, are permitted provided that the following    *
* condition is met:                                                  *
*                                                                    *
* - Redistributions of source code must retain the above copyright   *
*   notice, this condition and the following disclaimer.             *
*                                                                    *
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND             *
* CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,        *
* INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF           *
* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE           *
* DISCLAIMED. IN NO EVENT SHALL SEGGER Microcontroller BE LIABLE FOR *
* ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR           *
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT  *
* OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;    *
* OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF      *
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT          *
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE  *
* USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH   *
* DAMAGE.                                                            *
*                                                                    *
**********************************************************************

-------------------------- END-OF-HEADER -----------------------------

File      : MKE18F16_Vectors.s
Purpose   : Exception and interrupt vectors for MKE18F16 devices.

Additional information:
  Preprocessor Definitions
    __NO_EXTERNAL_INTERRUPTS
      If defined,
        the vector table will contain only the internal exceptions
        and interrupts.
    __VECTORS_IN_RAM
      If defined,
        an area of RAM, large enough to store the vector table,
        will be reserved.

    __OPTIMIZATION_SMALL
      If defined,
        all weak definitions of interrupt handlers will share the
        same implementation.
      If not defined,
        all weak definitions of interrupt handlers will be defined
        with their own implementation.
*/
        .syntax unified

/*********************************************************************
*
*       Macros
*
**********************************************************************
*/

//
// Directly place a vector (word) in the vector table
//
.macro VECTOR Name=
        .section .vectors, "ax"
        .code 16
        .word \Name
.endm

//
// Declare an exception handler with a weak definition
//
.macro EXC_HANDLER Name=
        //
        // Insert vector in vector table
        //
        .section .vectors, "ax"
        .word \Name
        //
        // Insert dummy handler in init section
        //
        .section .init.\Name, "ax"
        .thumb_func
        .weak \Name
        .balign 2
\Name:
        1: b 1b   // Endless loop
.endm

//
// Declare an interrupt handler with a weak definition
//
.macro ISR_HANDLER Name=
        //
        // Insert vector in vector table
        //
        .section .vectors, "ax"
        .word \Name
        //
        // Insert dummy handler in init section
        //
#if defined(__OPTIMIZATION_SMALL)
        .section .init, "ax"
        .weak \Name
        .thumb_set \Name,Dummy_Handler
#else
        .section .init.\Name, "ax"
        .thumb_func
        .weak \Name
        .balign 2
\Name:
        1: b 1b   // Endless loop
#endif
.endm

//
// Place a reserved vector in vector table
//
.macro ISR_RESERVED
        .section .vectors, "ax"
        .word 0
.endm

//
// Place a reserved vector in vector table
//
.macro ISR_RESERVED_DUMMY
        .section .vectors, "ax"
        .word Dummy_Handler
.endm

/*********************************************************************
*
*       Externals
*
**********************************************************************
*/
        .extern __stack_end__
        .extern Reset_Handler
        .extern HardFault_Handler

/*********************************************************************
*
*       Global functions
*
**********************************************************************
*/

/*********************************************************************
*
*  Setup of the vector table and weak definition of interrupt handlers
*
*/
        .section .vectors, "ax"
        .code 16
        .balign 512
        .global _vectors
_vectors:
        //
        // Internal exceptions and interrupts
        //
        VECTOR __stack_end__
        VECTOR Reset_Handler
        EXC_HANDLER NMI_Handler
        VECTOR HardFault_Handler
        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        ISR_RESERVED
        EXC_HANDLER SVC_Handler
        ISR_RESERVED
        ISR_RESERVED
        EXC_HANDLER PendSV_Handler
        EXC_HANDLER SysTick_Handler
        //
        // External interrupts
        //
#ifndef __NO_EXTERNAL_INTERRUPTS
        ISR_HANDLER DMA0_IRQHandler
        ISR_HANDLER DMA1_IRQHandler
        ISR_HANDLER DMA2_IRQHandler
        ISR_HANDLER DMA3_IRQHandler
        ISR_HANDLER DMA4_IRQHandler
        ISR_HANDLER DMA5_IRQHandler
        ISR_HANDLER DMA6_IRQHandler
        ISR_HANDLER DMA7_IRQHandler
        ISR_HANDLER DMA8_IRQHandler
        ISR_HANDLER DMA9_IRQHandler
        ISR_HANDLER DMA10_IRQHandler
        ISR_HANDLER DMA11_IRQHandler
        ISR_HANDLER DMA12_IRQHandler
        ISR_HANDLER DMA13_IRQHandler
        ISR_HANDLER DMA14_IRQHandler
        ISR_HANDLER DMA15_IRQHandler
        ISR_HANDLER DMA_Error_IRQHandler
        ISR_HANDLER MCM_IRQHandler
        ISR_HANDLER FTFE_IRQHandler
        ISR_HANDLER Read_Collision_IRQHandler
        ISR_HANDLER LVD_LVW_IRQHandler
        ISR_HANDLER Doublebit_Fault_IRQHandler
        ISR_HANDLER WDOG_EWM_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_HANDLER LPI2C0_IRQHandler
        ISR_HANDLER LPI2C1_IRQHandler
        ISR_HANDLER LPSPI0_IRQHandler
        ISR_HANDLER LPSPI1_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_HANDLER PWT_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_HANDLER LPUART0_TX_IRQHandler
        ISR_HANDLER LPUART0_RX_IRQHandler
        ISR_HANDLER LPUART1_TX_IRQHandler
        ISR_HANDLER LPUART1_RX_IRQHandler
        ISR_HANDLER LPUART2_TX_IRQHandler
        ISR_HANDLER LPUART2_RX_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_HANDLER ADC0_IRQHandler
        ISR_HANDLER CMP0_IRQHandler
        ISR_HANDLER CMP1_IRQHandler
        ISR_HANDLER FTM0_IRQHandler
        ISR_HANDLER FTM1_IRQHandler
        ISR_HANDLER FTM2_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_HANDLER RTC_IRQHandler
        ISR_HANDLER RTC_Seconds_IRQHandler
        ISR_HANDLER LPIT0_Ch0_IRQHandler
        ISR_HANDLER LPIT0_Ch1_IRQHandler
        ISR_HANDLER LPIT0_Ch2_IRQHandler
        ISR_HANDLER LPIT0_Ch3_IRQHandler
        ISR_HANDLER PDB0_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_HANDLER DAC0_IRQHandler
        ISR_HANDLER SCG_RCM_IRQHandler
        ISR_HANDLER LPTMR0_IRQHandler
        ISR_HANDLER PORTA_IRQHandler
        ISR_HANDLER PORTB_IRQHandler
        ISR_HANDLER PORTC_IRQHandler
        ISR_HANDLER PORTD_IRQHandler
        ISR_HANDLER PORTE_IRQHandler
        ISR_HANDLER SWI_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_HANDLER PDB1_IRQHandler
        ISR_HANDLER FLEXIO_IRQHandler
        ISR_HANDLER CMP2_IRQHandler
        ISR_HANDLER FTM3_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_HANDLER ADC1_IRQHandler
        ISR_HANDLER ADC2_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_HANDLER PDB2_IRQHandler
        ISR_HANDLER CAN0_ORed_IRQHandler
        ISR_HANDLER CAN0_Error_IRQHandler
        ISR_HANDLER CAN0_Wake_Up_IRQHandler
        ISR_HANDLER CAN0_ORed_Message_buffer_IRQHandler
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_RESERVED_DUMMY
        ISR_HANDLER CAN1_ORed_IRQHandler
        ISR_HANDLER CAN1_Error_IRQHandler
        ISR_HANDLER CAN1_Wake_Up_IRQHandler
        ISR_HANDLER CAN1_ORed_Message_buffer_IRQHandler
#endif
        //
        .section .vectors, "ax"
_vectors_end:

#if 1
  .section .vectors, "ax"
  // fill to 0x400 for the flash configuration field
  //.fill 0x400-(_vectors_end-_vectors), 1, 0xFF
  .org 0x400, 0xFF
BackDoorKey:
  .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
FPROT:
  .byte 0xFF, 0xFF, 0xFF, 0xFF
FSEC:
  .byte 0xFE
FOPT:
  .byte 0x7D
FEPROT:
  .byte 0xFF
FDPROT:
  .byte 0xFF
#endif

#ifdef __VECTORS_IN_RAM
        //
        // Reserve space with the size of the vector table
        // in the designated RAM section.
        //
        .section .vectors_ram, "ax"
        .balign 512
        .global _vectors_ram

_vectors_ram:
        .space _vectors_end - _vectors, 0
#endif

/*********************************************************************
*
*  Dummy handler to be used for reserved interrupt vectors
*  and weak implementation of interrupts.
*
*/
        .section .init.Dummy_Handler, "ax"
        .thumb_func
        .weak Dummy_Handler
        .balign 2
Dummy_Handler:
        1: b 1b   // Endless loop


/*************************** End of file ****************************/

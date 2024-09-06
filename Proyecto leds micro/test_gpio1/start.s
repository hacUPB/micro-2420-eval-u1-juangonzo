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
*********************************************************************/

/*********************************************************************
*
*       _start
*
*  Function description
*  Defines entry point for an MKE18F16 assembly code only
*  application.
*
*  Additional information
*    Please note, as this is an assembly code only project, the C/C++
*    runtime library has not been initialised. So do not attempt to call
*    any C/C++ library functions because they probably won't work.
*/

        .syntax unified
        .global _start
        .text

        .equ    PCC_BASE, 0x40065000 //clock 
        .equ    PCC_PORTD_OFFSET, 0x130
        .equ    PCC_CGC_BIT, 30

        .equ    PORTD_BASE, 0x4004C000
        .equ    PORT_PCR_MUX_BITS, 0x8
        .equ    PORTD_PCR7_OFFSET, 0x1C
        .equ    PORTD_PCR6_OFFSET, 0x18

        .equ    GPIOD_BASE, 0x400FF0C0
        .equ    GPIOD7_OFFSET, 7
        .equ    GPIO_DDR, 0x14
        .equ    GPIO_PDOR, 0x0
        .equ    GPIO_PDIR, 0x10


        .thumb_func
_start:
    bl  init_clks
    bl  init_ports
    bl  init_gpio

main_loop:
    bl  leer_pulsador
    bl  escribir_led
    b   main_loop

  

init_clks:
    ldr     r4, =#PCC_BASE
    ldr     r5, =#PCC_PORTD_OFFSET
    mov     r0, #1
    lsl     r0, #PCC_CGC_BIT
    str     r0, [r4, r5]
    bx      lr

init_ports:
    ldr     r4, =#PORTD_BASE
    mov     r0, #1
    lsl     r0, #PORT_PCR_MUX_BITS
    ldr     r5, =#PORTD_PCR7_OFFSET
    str     r0, [r4, r5]
    ldr     r5, =#PORTD_PCR6_OFFSET
    orr     r0, #3
    str     r0, [r4, r5]
    bx      lr 

init_gpio:
    ldr     r4, =#GPIOD_BASE
    mov     r0, #1
    lsl     r0, #GPIOD7_OFFSET
    ldr     r5, =#GPIO_DDR
    ldr     r1, [r4, r5]
    orr     r0, r1
    str     r0, [r4, r5]
    bx      lr



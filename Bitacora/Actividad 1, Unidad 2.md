Termino el ejercicio 1 unidad 2. 

.syntax unified
    .global _start
    .text
    .equ direccion_base, 0x20000800

.thumb_func

_start:
    bl  guardar_datos
    bx  lr

guardar_datos:
    ldr   r4, =direccion_base
    mov   r0, #50     // Inicializa el primer número a guardar
    mov   r1, #140    // Último número a guardar
loop_guardar:
    str   r0, [r4], #4 // Guarda el número en la memoria y avanza a la siguiente posición
    adds  r0, #10     // Incrementa el número en 10 para el siguiente ciclo
    cmp   r0, r1       // Compara si se ha alcanzado el último número
    ble   loop_guardar // Si no se ha alcanzado el último número, continuar guardando
    bx    lr           // Retorna

--

Termino ejercicio 2 Unidad 2 comentando lo que hace el codigo

.syntax unified
.global _start
.text

.thumb_func
_start:
    bl  init
    bl  cargar_memoria
loop:
    bl  copiar_datos
    b   loop

init:
    mov   r0, #0 //Mueve el valor "0" al registro r0
    mov   r1, #0 //Mueve el valor "0" al registro r1
    mov   r2, #0 //Mueve el valor "0" al registro r2
    bx    lr

cargar_memoria:
    ldr   r4, =#0x20000000 //carga esta direccion en el registro r4
    mov   r0, #1 //mueve el valor 1 al registro r0
    mov   r1, #10 //mueve el valor 10 al registro r1
loop_carga:
    str   r0, [r4], #4 //Escribe el valor de r0 (1) en r4 (r4 en este caso esta ligado a un registro) la direccion de memoria 0x20000000 y avanza 4
	  adds  r1, #-1 //El valor del registro r1 (que es 10) se le suma -1 y como tiene la "s" pregunta si la bandera del 0 se activa
    beq   fin_carga //Si es 0 nos salimos del loop y pasamos a "fin_carga"
    b     loop_carga //vuelve a iniciar "loop_carga"
fin_carga:
    bx    lr

copiar_datos:
    ldr   r4, =#0x20000000 //Cargamos esta direccion en el registro r4
loop_copia:
    ldr   r0, [r4] //Lo que hay en la direccion 0x20000000 lo cargamos en el registro r0
    cmp   r0, #0 //Compara el registro r0 con 0
    beq   fin_copia //si es 0 se mueve a fin_copia
    str   r0, [r4, #0x100] //movemos los datos de la direccion 0x20000000 a una nueva +100
    add   r4, #4 //avanza 4 bytes en la memoria
    b     loop_copia
fin_copia:
    bx    lr

--

Ejercicio 3 Unidad 2

Hago el numero 7 para la tabla 8x8

leds:
    .byte 0b11111111  
    .byte 0b00000001  
    .byte 0b00000010  
    .byte 0b00000100  
    .byte 0b00001000  
    .byte 0b00010000  
    .byte 0b00100000  
    .byte 0b01000000 

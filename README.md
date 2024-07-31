[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/EID3BRwM)
# Unidad 1
CPU: Una unidadcentral de procesaiento esla parte mas importante de un computador. La CPU es un hardware que performa datos de entrada y salida. Una CPU puede procesar multiple informacion y tareas almismo tiempo. Fuente https://www.geeksforgeeks.org/central-processing-unit-cpu/
ALU: La ALU (unidad aritmética lógica) es un circuito electrónico cuya función es llevar a cabo todos los procesos relacionados con los procedimientos de lógica y cálculo numérico. Figura como un componente indispensable de la unidad central de procesamiento (CPU) de las computadoras.

Las CPU recientes incluyen ALU muy potentes y complejas. En algunas estructuras de CPU, la ALU se divide en una unidad aritmética y una unidad lógica. Además de la ALU, las CPU actuales incluyen una unidad de control. Fuente: https://www.lifeder.com/unidad-aritmetica-logica/
Registros: 
a. Registros deproposito general: Los registros de propósito general (GPR, por sus siglas en inglés) son utilizados para almacenar datos temporales durante la ejecución de programas. En los microprocesadores como el 8086, hay ocho registros de propósito general: AX, BX, CX, DX, SP, BP, SI, y DI. Estos registros pueden almacenar tanto datos como direcciones, permitiendo realizar operaciones aritméticas, lógicas y de manipulación de datos de manera eficiente​ (Tutorialspoint)​​ (Binary Terms)​.
b. Registros especificos: 
Program Counter (PC): Este registro contiene la dirección de la próxima instrucción a ser ejecutada. Se incrementa automáticamente después de cada instrucción para apuntar a la siguiente.
Stack Pointer (SP): Este registro apunta a la parte superior de la pila, que es una estructura de datos utilizada para almacenar información temporal como direcciones de retorno y variables locales durante las llamadas a subrutinas.
Base Pointer (BP): Utilizado para acceder a los parámetros pasados en la pila.
Instruction Register (IR): Contiene la instrucción actual que se está ejecutando.
Memory Address Register (MAR) y Memory Buffer Register (MBR): MAR contiene la dirección de la memoria a la que se va a acceder, mientras que MBR contiene los datos que se van a escribir o los datos leídos recientemente de la memoria​ (Binary Terms)​.
Unidad de control: La unidad de control (CU) es una parte crucial de la CPU que dirige las operaciones del procesador. Interpreta las instrucciones del programa y genera señales de control para coordinar todas las actividades dentro del procesador. La CU se encarga de la secuencia de operaciones y el flujo de datos entre las diferentes unidades funcionales de la CPU, asegurando que las instrucciones se ejecuten correctamente​ (Binary Terms)​. 
Buses de datos: 
Bus de Datos: Este bus transfiere datos entre los componentes de la computadora. Es bidireccional, lo que permite tanto la lectura como la escritura de datos.
Bus de Dirección: Este bus transfiere direcciones que especifican dónde se debe leer o escribir datos en la memoria. Es unidireccional, enviando direcciones desde la CPU a la memoria u otros dispositivos​ (Binary Terms)​.
Memoria: 
La memoria es un componente esencial de los sistemas computacionales. Existen varios tipos de memoria:
RAM (Memoria de Acceso Aleatorio): Memoria volátil utilizada para almacenar datos temporales y programas que están en ejecución.
ROM (Memoria de Solo Lectura): Memoria no volátil que almacena firmware y datos que no cambian.
Cache: Una memoria de alta velocidad que almacena copias de los datos más frecuentemente utilizados para un acceso rápido​ (Binary Terms)​.
Opcode: Un opcode (código de operación) es una parte de una instrucción de máquina que especifica la operación a realizar. Es la porción de una instrucción que indica al hardware del CPU qué operación ejecutar, como suma, resta, carga, almacenamiento, etc. Los opcodes son esenciales en el lenguaje de máquina, ya que determinan la funcionalidad de cada instrucción ejecutada por el procesador​ (Binary Terms)​.
Referencias: 
GeeksforGeeks, "General Purpose Registers" y "Different Classes of CPU Registers"
TutorialsPoint, "What are the CPU general purpose registers?"
Binary Terms, "What is Register Organization? What is Register? Types of Register"

Descripcion componentes vistos:
En el circuito podemos observar un computador compuesto por una CPU, una memoria ROM donde se carga el programa,Un clockque es la frecuencia a la que el procesadoresta funcionando, y otra memoria que guarda los datos donde se va a operar y las entradas de datos de los perfifericos.

Fetch: Es ir a buscar la instruccion en la ROM. Se escribe la direccion de memoria donde esta la informacion en el registro A. Luego el registro "PC" me indica cual es el siguiente registro a realizar. El empieza en "0". Decode determina que es lo que hace la instruccion, si es tipo A o tipo C, etc.

Para el tipo A puede direccionar 32kb registros. 

Instruccion tipo A, almacena valores en el registro A y operaciones sencillas. Intruccion tipo C, puede asignar valores, Crear condicionales, saltos, cambiar el flujo del programa, entre otras cosas.

lsl: rota a la izquierda(multiplicax2) pero ojo porque no guarda el simbolo
lsr: rota a la derecha y llena de 0s a la izquierda
asr: rota ala derecha pero es arimetico osea toma el simbolo
ror: rota a la derecha pero lo que se sale entra al bit mas significativo
movs: la s actualiza el registro de estado
movw: para mover un numero de 16bits 
movw: mueve el numero a los digitos menos significativos del registro
movt: mueve el numero a la parte alta del registro
str: store, almacenar en la memoria ram el dato ej. STR R1, [R0]. En la direccion de memoria R0 almacene el dato del registro R1
strb: lo mismo que str pero solo  en un byte. ej STRB R2, [R0, #4] guarda la info del registro R2 en la direccion de memoria R0 y le añade 4
strh: half word.una palabra es de 32 bits, hlaf word es 16 bit y byte 8 bits

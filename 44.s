// Archivo: 44.s
// Autor: Rodriguez Gallardo Alan Paul
// Objetivo: Generador de números pseudoaleatorios con semilla

/*
    using System;

class GeneradorAleatorio
{
    static void Main()
    {
        // Solicitar al usuario que ingrese una semilla
        Console.Write("Ingresa una semilla para el generador de números aleatorios: ");
        int semilla = Convert.ToInt32(Console.ReadLine());

        // Crear una instancia de Random utilizando la semilla
        Random random = new Random(semilla);

        // Generar algunos números aleatorios
        Console.WriteLine("Generando 5 números aleatorios:");
        for (int i = 0; i < 5; i++)
        {
            int numeroAleatorio = random.Next();
            Console.WriteLine(numeroAleatorio);
        }
    }
}

*/

.global _start

.section .bss
seed: .skip 8              // Espacio para la semilla
rand_number: .skip 8       // Espacio para almacenar el número aleatorio

.section .text
_start:
    // Establecer la semilla
    ldr x0, =seed
    mov x1, #159      // Semilla inicial (puedes cambiar este valor)
    str x1, [x0]            // Guardar semilla en memoria

    // Parámetros del generador congruente lineal
    mov x2, #15        // Constante 'a'
    mov x3, #101     // Constante 'c'
    mov x4, #429     // Constante 'm' (2^32)

    // Generar el siguiente número aleatorio
    ldr x1, =seed           // Cargar la semilla
    ldr x1, [x1]            // Leer el valor de la semilla
    mul x5, x1, x2          // x5 = Xₙ * a
    add x5, x5, x3          // x5 = (Xₙ * a) + c
    udiv x5, x5, x4          // x5 = (Xₙ * a + c) % m
    str x5, [x1]            // Guardar el nuevo número en la semilla

    // Guardar el número aleatorio
    ldr x0, =rand_number    // Dirección para almacenar el número aleatorio
    str x5, [x0]            // Guardar el número aleatorio

    // Terminar el programa
    mov x8, #93             // syscall número 93 (exit)
    mov x0, #0              // código de salida 0
    svc #0                  // Llamada al sistema

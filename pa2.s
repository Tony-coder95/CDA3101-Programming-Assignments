// Got a 100%
.section .data
input_prompt:   .asciz "Please enter a number betwen 1 and 10 \n"
input_spec:     .asciz "%d"
fib_result:     .asciz "%d\n"
oob_mess:       .asciz "Input is out of bounds \n"

.section .text
.global main
.global fib

main:
    // Create room on the stack for input
    sub sp, sp, #16

    // Print input prompt
    ldr x0, =input_prompt
    bl printf

    // Read user input
    ldr x0, =input_spec
    mov x1, sp  // Store input at stack
    bl scanf

    // Load input value from stack
    ldr w0, [sp]

    // Restore stack
    add sp, sp, #16

    // Check if input is in valid range (1-10)
    cmp w0, 1
    blt out_of_bounds
    cmp w0, 10
    bgt out_of_bounds

    // Create stack frame before recursive call
    sub sp, sp, #16
    str x30, [sp, #8]
    str w0, [sp, #0]

    bl fib

    // Restore values after call
    ldr w1, [sp, #0]  // Original input
    ldr x30, [sp, #8]
    add sp, sp, #16

    // Print Fibonacci value
    mov x1, x0  // Move computed Fibonacci value to x1
    ldr x0, =fib_result
    bl printf

    b exit

out_of_bounds:
    ldr x0, =oob_mess
    bl printf
    b exit

// Recursive Fibonacci Function
fib:
    // Create stack frame
    sub sp, sp, #16
    str x30, [sp, #8]
    str w0, [sp, #0]

    // Base cases: Fib(1) = 0, Fib(2) = 1
    cmp w0, 1
    beq fib_base0
    cmp w0, 2
    beq fib_base1

    // Compute Fib(n-1)
    sub w0, w0, 1
    bl fib
    str w0, [sp, #4]  // Store Fib(n-1) result on stack

    // Compute Fib(n-2)
    ldr w0, [sp, #0]  // Restore original n
    sub w0, w0, 2
    bl fib

    // Add Fib(n-1) + Fib(n-2)
    ldr w1, [sp, #4]  // Load Fib(n-1) result
    add w0, w0, w1

    b fib_return

fib_base0:
    mov w0, 0
    b fib_return

fib_base1:
    mov w0, 1
    b fib_return

fib_return:
    ldr x30, [sp, #8]
    add sp, sp, #16
    ret

exit:
    mov x0, #0
    mov x8, #93
    svc #0


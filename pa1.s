## got a 90%
.section .data

input_prompt:   .asciz "Input a string: "
input_spec:     .asciz "%[^\n]"
length_format:  .asciz "String length: %d\n"
palindrome_msg: .asciz "String is a palindrome (T/F): %c\n"

buffer:         .space 64  // Input buffer for user string

.section .text
.global main

main:
    // Print prompt
    ldr x0, =input_prompt
    bl printf

    // Read input
    ldr x0, =input_spec
    ldr x1, =buffer
    bl scanf

    // Calculate string length
    ldr x19, =buffer
    mov x20, x19  // Start pointer

count_length:
    ldrb w0, [x19]  // Load character
    cbz w0, done_counting
    add x19, x19, #1
    b count_length

done_counting:
    sub x19, x19, x20  // Compute string length

    // Print length
    ldr x0, =length_format
    mov x1, x19
    bl printf

    // Palindrome check
    mov x21, x20  // Start of string
    add x22, x20, x19  // End of string
    sub x22, x22, #1  // Adjust pointer

check_palindrome:
    cmp x21, x22
    bge is_palindrome  // If start >= end, it's a palindrome

    ldrb w10, [x21]  // Load left character
    ldrb w11, [x22]  // Load right character

    // Convert uppercase to lowercase
    cmp w10, #'A'
    blt skip_lower1
    cmp w10, #'Z'
    bgt skip_lower1
    add w10, w10, #32  // Convert uppercase to lowercase
skip_lower1:

    cmp w11, #'A'
    blt skip_lower2
    cmp w11, #'Z'
    bgt skip_lower2
    add w11, w11, #32  // Convert uppercase to lowercase
skip_lower2:

    cmp w10, w11
    bne not_palindrome

    add x21, x21, #1  // Move forward
    sub x22, x22, #1  // Move backward
    b check_palindrome

is_palindrome:
    mov x1, 'T'
    b print_result

not_palindrome:
    mov x1, 'F'

print_result:
    ldr x0, =palindrome_msg
    bl printf

exit:
    mov x0, 0
    mov x8, 93
    svc 0


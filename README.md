# CDA3101-Programming-Assignments
# Programming Assignment 1 - ARM Assembly

## **Overview**
This repository contains the solution for **Programming Assignment 1** of CDA3101. The goal of this assignment is to implement an **ARM Assembly** program that reads a string, calculates its length, determines if it is a palindrome, and prints the results.

## **Objective**
The ARM program performs the following tasks:
1. Prints **"Input a string:"**.
2. Reads the input string.
3. Calculates the **length** of the string.
4. Outputs the string length to the console.
5. Checks if the string is a **palindrome**.
6. Outputs whether the string is a palindrome **(T/F)**.

## **Files**
- `pa1.s` → ARM Assembly source code for the program.

# Programming Assignment 2 - Recursive Fibonacci in ARM Assembly

## **Overview**
This repository contains the solution for **Programming Assignment 2** of CDA3101.  
The goal of this assignment is to implement an **ARM Assembly** program that:
- Reads an integer input (1 to 10).
- Recursively calculates the **nth** number in the Fibonacci sequence.
- Outputs the computed Fibonacci number.
This assignment focuses on understanding **recursion** and **procedure calls** in ARM Assembly.

## **Objective**
Use the following algorithm to calculate the **nth** number in the Fibonacci sequence.  
Inputs will be from **1 to 10**, with the following expected outputs:

fib(1) → 0
fib(2) → 1
fib(3) → 1
fib(4) → 2
fib(5) → 3
and so on...

## **Requirements and Specifications**
- **Global variables cannot be used** to store inputs. Use the **stack** instead.
- `X19-X27` are **reserved global variables** and **cannot be used in the recursive function.**
- **Main function:** Can use any registers, including `X19-X27`.
- **Recursive function:** Must follow stack frame conventions:
  - Allocate stack space
  - Save the return address and arguments on the stack
  - Use `BL` for recursive calls
  - Restore the return address and arguments after the recursive call.

---

## **Testing Instructions**
```sh
gcc -o pa2 pa2.s
stdbuf -oL ./pa2 <1.in >test-1.out
diff test-1.out 1.out

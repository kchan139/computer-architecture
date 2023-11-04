    .data
array:  .space 80   # Array of 20 integers, each integer takes 4 bytes (20 * 4 = 80)
prompt: .asciiz "Enter 20 integers: "
newline: .asciiz "\n"


.text
.globl main

main:
    li $t0, 20           # Initialize $t0 to 20 (number of elements)
    la $t1, array        # Load base address of array into $t1

    # Prompt user to enter 20 integers
    li $v0, 4
    la $a0, prompt
    syscall

    # Loop to input 20 integers into the array
input_loop:
    beq $t0, $zero, reverse_array  # If $t0 is 0, go to reversing the array

    li $v0, 5            # Read integer
    syscall
    sw $v0, 0($t1)       # Store integer in the array
    addi $t1, $t1, 4     # Move to the next element in the array
    sub $t0, $t0, 1      # Decrement the counter
    j input_loop          # Repeat input loop

reverse_array:
    la $t1, array         # Re-initialize $t1 to the base address of the array
    li $t2, 0            # Initialize $t2 to 0 (start index)
    li $t3, 19           # Initialize $t3 to 19 (end index)

reverse_loop:
    bge $t2, $t3, print_reversed_array  # If start index is greater than or equal to end index, print the reversed array

    lw $t4, 0($t1)       # Load value at start index
    lw $t5, 0($t1)       # Load value at end index
    sw $t5, 0($t1)       # Store value at start index in place of value at end index
    sw $t4, 0($t1)       # Store value at end index in place of value at start index

    addi $t1, $t1, 4     # Move to the next element from the beginning
    addi $t2, $t2, 1     # Increment start index
    sub $t3, $t3, 1      # Decrement end index
    j reverse_loop        # Repeat reverse loop

print_reversed_array:
    la $t1, array         # Re-initialize $t1 to the base address of the array

    # Print the reversed array
    li $t0, 20            # Re-initialize $t0 to 20 (number of elements)

print_loop:
    beq $t0, $zero, end_program  # If $t0 is 0, end the program

    lw $a0, 0($t1)        # Load value to print
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline       # Print newline for formatting
    syscall

    addi $t1, $t1, 4      # Move to the next element in the array
    sub $t0, $t0, 1       # Decrement the counter
    j print_loop           # Repeat print loop

end_program:
    li $v0, 10             # Exit syscall
    syscall

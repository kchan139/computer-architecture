.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
size: .word 20
newline: .asciiz "\n"


.text
main:
	la $t0, array
	lw $t1, size
	
	addi $t1, $t1, -1
	sll $t1, $t1, 2 	 # last index byte offset
	
	
reverse:
	beq $t2, $zero, exit
	
	sub $t2, $t1, $t0	 # last element address
	
	lw $t3, ($t0) 		 # S
	lw $t4, ($t2)		 # W
	sw $t4, ($t0)        # A
    sw $t3, ($t2)		 # P
    
    addiu $t0, $t0, 4
    addiu $t1, $t1, -4
    j reverse
    
    
print_loop:
    beqz $t1, exit 
    
    lw $a0, ($t0)     
    ori $v0, $zero ,1       
    syscall                

    la $a0, newline
    ori $v0, $zero, 4
    syscall           

    addiu $t0, $t0, 4 
    addiu $t1, $t1, -1
    j print_loop      
    
    
exit:
	ori   $v0, $zero, 10
	syscall
	
	
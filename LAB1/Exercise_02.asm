.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
size: .word 20

.text
main:
    la $t0, array
    lw $t1, size
    sll $t1, $t1, 2
    add $t1, $t1, $t0

reverse:
    subu $t1, $t1, 4
    lw $t2, 0($t0)
    lw $t3, 0($t1)
    sw $t2, 0($t1)
    sw $t3, 0($t0)
    addiu $t0, $t0, 4
    slt $t4, $t0, $t1
    bnez $t4, reverse

exit:
    li $v0, 10
    syscall

.data
vet : .word 1, 2, 3, 4, 5, 100, 0, 56
DIM = 8
.text
.globl main
.ent main
main:
	la $a0, vet
	add $a1, $0, DIM
	jal maxVett
	add $a0, $0, $v0
	li 	$v0, 1
	syscall
	li $v0, 10
	syscall
.end main

.ent maxVett
maxVett: 
	addi $t0, $0 ,0x0001
	lw $v0, 0($a0)
	add $a0, $a0, 0x0004
for: bge $t0, $a1, done
	lw $t2 , 0($a0)
	bge $v0 , $t2 , next
	sub $t2, $t2, $v0
	add  $v0, $v0, $t2
next:addi $t0, 0x0001
	add $a0, $a0, 0x0004
	b for
done: jr $ra
.end maxVett

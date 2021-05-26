.data
par1 : .word 1
par2 : .word -2
par3: .word 34
par4 : .word 123
.text
.globl main
.ent main
main:
	lw $a0, par1
	lw $a1, par2
	lw $a2, par3
	lw $a3, par4
	jal determinante2x2
	add $a0, $v0, $0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
.end main

.ent determinante2x2
determinante2x2: 
	mul $t0, $a0, $a3
	mul $t1, $a1, $a2
	sub $v0, $t0, $t1
	jr $ra
.end determinante2x2

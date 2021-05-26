.data
par1 : .word 1
par2 : .word -256
par3: .word 34
par4 : .word 123
par5 : .word 1
par6 : .word -2
par7: .word 34
par8 : .word 10
par9: .word 34

.text
.globl main
.ent main
main:
	lw $a0, par1
	lw $a1, par2
	lw $a2, par3
	lw $a3, par4
	
	subu $sp, $sp, 20
	
	lw $t0, par5
	sw $t0, 0($sp)
	
	lw $t0, par5
	sw $t0, 4($sp)
	
	lw $t0, par7
	sw $t0, 8($sp)
	
	lw $t0, par8
	sw $t0, 12($sp)
	
	lw $t0, par9
	sw $t0, 16($sp)

	jal determinante3x3
	
	addiu $sp, $sp, 20
	
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

.ent determinante3x3
determinante3x3:
	sub $sp, $sp, 4
	sw $ra , 0($sp)
	move $t2, $a0
	move $t3, $a1
	move $t4, $a2
	move $t5, $a3
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 16($sp)
	lw $a3, 20($sp)
	jal determinante2x2
	mul $t2, $t2, $v0
	
	move $a0, $t5
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 20($sp)
	jal determinante2x2
	mul $t3, $t3, $v0
	
	sub $t2, $t2, $t3
	
	move $a0, $t5
	lw $a1, 4($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	jal determinante2x2
	mul $t4, $t4, $v0
	add $t2, $t2, $t3
	
	lw $ra, 0($sp)
	add $sp, $sp, 4
	
	jr $ra
.end determinante3x3

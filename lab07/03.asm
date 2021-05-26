.data
msg1 : .asciiz "Inserire Intero di partenza o\n\t->"
msg2 : .asciiz "\t"
.text
.globl main
.ent main
main:
	
	la $a0,msg1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	
	move $a0, $v0
	jal sequenzaDiCollatz
	
	add $a0, $v0, $0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
.end main

.ent calcolaSuccessivo
calcolaSuccessivo : 
	sll $t0, $a0, 3 # 00001111001 10000
	and $t0, $a0, 0x0001
	beq $t0 , $0, pari
	mul $t0, $a0 , 3
	addiu $t0, $t0, 0x0001
	b returnCalcolaSuccessivo
pari:
	srl $t0, $a0, 1
returnCalcolaSuccessivo:
	add $a0, $t0, $0
	li $v0, 1
	syscall
	la $a0, msg2
	li $v0, 4
	syscall
	add $v0, $0, $t0
	jr $ra
.end calcolaSuccessivo

.ent sequenzaDiCollatz
sequenzaDiCollatz : 
	#a0 = valore di partenza
	add $t0, $0, $0
	add $t1, $a0, $0
	doWhile:
		beq $t1, 0x0001, returnSequenzaDiCollatz
		sub $sp, $sp, 8
		
		sw $t0, 0($sp)
		#sw $t1, 4($sp)
		sw $ra, 4($sp)
		
		add $a0, $0, $t1
		jal calcolaSuccessivo
		
		lw $t0, 0($sp)
		#lw $t1, 4($sp)
		lw $ra, 4($sp)
		
		add $t1, $v0, $0
		addiu $t0, $t0, 0x0001
		bne $t1, 0x0001, doWhile
returnSequenzaDiCollatz: 
	add $v0, $0, $t0
	jr $ra
.end sequenzaDiCollatz



.data
msg1 : .asciiz "Inserire Intero di partenza o\n\t->"
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
	jal calcolaSuccessivo
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
	add $v0, $0, $t0
	jr $ra
.end calcolaSuccessivo



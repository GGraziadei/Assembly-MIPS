.data 
n1: .byte 200
n2: .byte 100
n3: .byte 10
#moltiplicando 8 x 8 x 8 il (2^3)3
#in sostanza mi bastano 9 bit per scrivere il risultato 
#questa assunzione mi è nota a priori

#RISUTALTO ATTESO = 10+(


res: .space 4

.text
.globl main
.ent main

main:
	la $t5,n1
	lb $t1,0($t5)
	andi $t1,$t1,0x000000FF
	li $t2, 24
	multu $t1,$t2
	mflo $t1
	la $t5,n2
	lb $t0,0($t5)
	andi $t0,$t0,0x000000FF
	add $t1,$t0,$t1
	li $t2, 60
	multu $t1,$t2
	mflo $t1
	la $t5,n3
	lb $t0,0($t5)
	andi $t0,$t0,0x000000FF
	add $t1,$t0,$t1
	
	li $v0, 1
	add $a0,$0,$t1
	syscall
	
	
	
li $v0, 10
syscall
.end main

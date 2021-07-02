.data
espressione: .word 18, 25, 10, 7, -2, -3, -1, 13, -2
tabella: .word somma, sottrazione, moltiplicazione, divisione
.text
.globl main
.ent main
main: subu $sp, $sp, 4
sw $ra, ($sp)
la $a0, espressione
li $a1, 9
jal calcolaPolaccaInversa
lw $ra, ($sp)
addu $sp, $sp, 4
jr $ra
.end main

calcolaPolaccaInversa:
subu $sp, $sp, 4
sw $ra, ($sp)
	add $t5, $a0, $0 #espressione
	add $t6, $a1, $0
	add $t4, $0, $0
	for: bge $t4, $t6, esci
		lw $t2, 0($t5)
		
		bgt $t2, $0, push #se operando fai il push 
		
		move $a0, $t2
		lw $a1, 0($sp)
		lw $a2, 4($sp)
		addiu $sp, $sp, 0x0008
		jal eseguiOperazione
		add $t2, $0, $v0
		
	push: subu $sp, $sp, 4
		  sw $t2, ($sp)
	next: addiu $t4, $t4, 0x0001
		  addu $t5, $t5, 0x0004
		  j for
esci:
lw $v0, 0($sp)
addu $sp, $sp, 4
lw $ra, ($sp)
addu $sp, $sp, 4
jr $ra
.end calcolaPolaccaInversa

eseguiOperazione:
	subu $t0, $zero, $a0
	subu $t0, $t0, 1
	sll  $t0, $t0, 2
	lw $t1, tabella($t0)
	jr $t1
	somma: addu $v0, $a1, $a2
		   b fine
	sottrazione: subu $v0, $a1, $a2
		   b fine
	moltiplicazione: mul $v0, $a1, $a2
		   b fine
	divisione: divu $v0, $a1, $a2
		   b fine
fine: jr $ra
.end eseguiOperazione
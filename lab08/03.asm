NUM = 5
DIM = NUM * 4
SCONTO = 30
ARROTONDA = 1
.data
prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM
.text
.globl main
.ent main
main: 
la $a0, prezzi
la $a1, scontati
li $a2, NUM
li $a3, SCONTO
li $t0, ARROTONDA
subu $sp, 4
sw $t0, ($sp)
jal calcola_sconto
addiu $sp, 4
li $v0, 10
syscall
.end main

.ent calcola_sconto
calcola_sconto:
	add $t0, $0, $0 # indice
	add $t1, $0, $0 # ammontare_di_sconti_applicati
	add $t3, $0, $0 # prezzo_corrente
	# $t6,  offset corrente
	lw $t2, 0($sp)  # arrotonda
	addiu $t7, $0, 100
	for: bge $t0, $a2, done
		add $t5, $0, $t0
		sll $t6, $t5, 2 
		add $t5, $a0, $t6
		lw $t3 , 0($t5)
		add $t5, $0, $t3
		mul $t5, $t5, $a3 
		div $t5, $t7
		mflo $t5 
		mfhi $t4
		beq $t2, $0 fineArrotonda
			blt $t4, 50, fineArrotonda
			addiu $t5, $t5, 0x0001
		fineArrotonda:
		subu $t3, $t3, $t5
		addu $t1, $t5, $t1
		add $t6, $t6, $a1
		sw $t3, 0($t6)
		add $t6, $0 , $a0
		add $a0, $t3, $0
		li $v0, 1
		syscall
		add $a0, $0, $t6 
		addiu $t0, $t0, 0x0001
		j for
done:
	add $v0, $0, $t1
	jr $ra
.end calcola_sconto
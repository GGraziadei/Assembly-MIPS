DIM = 4
.data
matrice: 
		.word 126, -988, 65, 52
		.word 7, 0, 2, 643
		.word 66, 532, 43, 9254
		.word 5, -51, 4352, -452
.text
.globl main
.ent main
main: subu $sp, $sp, 4
sw $ra, ($sp)
la $a0, matrice
li $a1, DIM
jal calcolaTrasp
lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main

.ent calcolaTrasp
calcolaTrasp:
subu $sp, $sp, 4
sw $ra, ($sp)
add $t0, $0, $a0 
add $t1, $0, $0 #i = 0
add $t3, $0, $a1 #DIM
add $a3, $t3, $0
forEsterno: bge $t1, $t3, fine
add $t2, $0, $0 #j = 0
	forInterno: bge $t2, $t3, nextRiga
	blt $t2, $t1, nextRiga
	
	add $a1, $0, $t1
	add $a2, $0, $t2
	jal calcolaIndirizzo
	add $t4, $0, $v0
	
	add $a1, $0, $t2
	add $a2, $0, $t1
	jal calcolaIndirizzo
	add $t5, $0, $v0
	
	lw $t6, 0($t4)
	lw $t7, 0($t5)
	sw $t6, 0($t5)
	sw $t7, 0($t4)
	
	addiu $t2, $t2, 0x0001 
	j forInterno
nextRiga : addiu $t1, $t1, 0x0001 
j forEsterno
fine:
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
.end calcolaTrasp

.ent calcolaIndirizzo
calcolaIndirizzo:
#a0 indirizzo base della matrice, a1 = indice righe ,
#a2 = indice delle colonne , a3 = dim
	mul $a1, $a3, $a1
	add $a1, $a1, $a2
	sll $a1, $a1, 2
	add $v0, $a1, $a0
jr $ra
.end calcolaIndirizzo
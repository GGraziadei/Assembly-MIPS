	.data
vettore: .byte 14, 16, 18, 134, 24, 22, 23, 149, 140, 141, 145, 146
vettoreCompresso: .space 12
INTERVALLO_QUANT = 10
.text
.globl main
.ent main
main:
	subu $sp, $sp, 4
	sw $ra, ($sp)
	la $a0, vettore
	li $a1, 12
	la $a2, vettoreCompresso
	jal comprimi
	lw $ra, ($sp)
	addu $sp, $sp, 4
	jr $ra
.end main
.ent comprimi
comprimi:
	subu $sp, $sp, 0x0004
	sw $ra, 0($sp)
	add $t0, $0, $a0 #vettore partenza
	add $t1, $0, $a1 #dimensione
	add $t2, $0, $a2  #vettoreCompresso
	addi $t3, $0,  -1  #ultimo valore compresso
	add $t4, $0, $0  #indice del vettore
	add $t5, $0, $0
ciclo: bge $t4, $t1, fineElaborazione
	add $v0, $0, $0
	subu $sp, $sp, 0x0004
	sw $t0, 0($sp)
	lb $a0, 0($t0)
	jal quantizza
	lw $t0, 0($sp)
	addiu $sp, $sp, 0x0004
	beq $v0, $t3, next
		move $t3, $v0
		sb $v0, ($t2)
		addiu $t5, $t5, 0x0001
		addiu $t2, $t2, 0x0001
	next:
	addiu $t4, $t4, 0x0001
	addiu $t0, $t0, 0x0001
	j ciclo
fineElaborazione:	
	lw $ra, 0($sp)
	addiu $sp, $sp, 0x0004
	add $v0, $t5, $0
jr $ra
.end comprimi
quantizza:
	divu $t0, $a0, INTERVALLO_QUANT
	mulou $v0, $t0, INTERVALLO_QUANT
jr $ra
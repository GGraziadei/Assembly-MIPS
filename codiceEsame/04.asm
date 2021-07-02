.data
vet: .word 15, 64, 9, 2, 4, 5, 9, 1, 294, 52, -4, 5
.text
.globl main
.ent main
main: subu $sp, $sp, 4
sw $ra, 0($sp)
la $a0, vet # indirizzo di vet
li $a1, 12 # dimensione di vet
jal monotono
lw $ra, 0($sp)
addiu $sp, $sp, 4
jr $ra

.ent monotono
monotono:
addiu $v0, $0, 0x0001 #indica la lunghezza della sequenza
and $v1, $0, $0 #indica l'indice di partenza della sequenza
and $t1, $0, $0 #indice scorrimento vettore esterno

cicloEsterno: 
lw $t2, 0($a0)
addiu $t3, $t1, 0x0001
addiu $t4, $a0, 0x0004
	cicloInterno: bge $t3, $a1, fineCicoloInterno
		lw $t5, 0($t4)
		blt $t5, $t2, fineCicoloInterno
		addiu $t4, $t4, 0x0004
		addiu $t3, $t3, 0x0001
		move $t2, $t5
		j cicloInterno
	fineCicoloInterno:
	subu $t5, $t3, $t1
ble $t5, $v0, fineUpdate
	add $v0, $0, $t5
	add $v1, $0, $t1
fineUpdate:
addiu $t1, $t1, 0x0001
addiu $a0, $a0, 0x0004
blt $t1, $a1, cicloEsterno

jr $ra
.end monotono
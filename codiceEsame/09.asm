.ent calcola
calcola:
	sub $sp, $sp, 0x0008
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	and $v0, $0, $0
	#a0 = indirizzo matrice, a1 = dimensione 
	and $t0, $0, $0
	addiu $t2, $0, 0x0001 #[0]1
	add $t3, $0, $a1 #offset = dimensione di una riga 
	sll $t3, $t3, 2
	
cicloRighe:
and $t1, $0, $0
add $t4, $0, $a0
	cicloColonne:
		lw $t5, 0($t4)
		and $t5, $t5, $t2
		beq $t5, $0, pari
			add $s1, $s1, $t5
		pari: add $s0, $s0, $t5
		dispari:
	add $t4, $t3, $t4
	addiu $t1, $t1, 0x0001
	blt $t1, $a1, cicloColonne
ble $s0, $s1, next
addiu $v0, $v0, 0x0001
next:
addiu $t0, $t0, 0x0001
addiu $a0, $a0, 0x0004
blt $t0, $a1, cicloRighe

	lw $s1, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 0x0008
j $ra 
.end 
DIM = 5
.data
vet1: .word 56, 12, 98, 129, 58
vet2: .word 1, 0, 245, 129, 12
risultato: .space DIM
.text
.globl main
.ent main
main: 
la $a0, vet1
la $a1, vet2
la $a2, risultato
li $a3, DIM
jal CalcolaDistanzaH
li $v0, 10
syscall

.end main

.ent CalcolaDistanzaH
CalcolaDistanzaH: 
	add $t0, $0, $0
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	#preservare : a0, a1, t0, t1
	for: bge $t0, $a3, done
		sll $t1, $t0, 2 
		subu $sp, $sp, 16
		sw $a0, 0($sp)
		sw $a1, 4($sp)
		sw $t0, 8($sp)
		sw $t1, 12($sp)
		add $a0, $t1, $a0
		lw $a0, 0($a0)
		add $a1, $t1, $a1
		lw $a1, 0($a1)
		jal CalcolaDistanza
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $t0, 8($sp)
		lw $t1, 12($sp)
		add $sp, $sp, 16
		add $t1, $a2, $t1
		sw $v0, ($t1)
		addiu $t0, $t0, 0x0001
		j for
done: 
	lw $ra, 0($sp)
	addu $sp, $sp, 4
	jr $ra
.end CalcolaDistanzaH

.ent CalcolaDistanza
CalcolaDistanza: 
	addiu $t0, $0, 0x0001 # 00000...01
	add $t1, $0 ,$0 	  # indice
	add $t2, $0, $0       # contatore di diff
	
	for1: bge $t1, 31, done1
		and $t3, $t0, $a0 #verifico se i bit coincidono
		and $t4, $t0, $a1
		beq $t3, $t4, continue
			addiu $t2, $t2, 0x0001
		continue:
				addiu $t1, $t1, 0x0001
				sll $t0, $t0, 1
		j for1
done1: 
	add $v0, $0, $t2
	jr $ra
.end CalcolaDistanza
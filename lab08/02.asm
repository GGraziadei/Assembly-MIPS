.data
DIM = 6
anni:      .word 1945, 2008, 1800, 2006, 1748, 1600
risultato: .space DIM
.text
.globl main
main: 
la  $a0, anni  # indirizzo di anni
la  $a1, risultato # indirizzo di risultato
addiu $a2, $0, DIM
jal bisestile
li $v0, 10
syscall
.end main
	
.ent bisestile
bisestile:
	add $t0, $0, $0
	add $t6, $0, 0x0001
	subu $sp, $sp, 0x0004
	sw $ra, 0($sp)
	for: bge $t0, $a2, done
		sll $t1, $t0, 2
		add $t4, $a0, $t1
		lw $s0, 0($t4)
		subu $sp, $sp, 0x0008
		sw $a0, 0($sp)
		sw $a1, 4($sp)
		
		add $a0, $0, $s0
		addiu $a1, $0, 100
		jal modulo
		bne $v0, $0, else
			addiu $a1, $0, 400
			j doneFor
		else: addiu $a1, $0, 4
		doneFor:
			add $a0, $0, $s0
			jal modulo
		add $t5, $0, $v0
		add $a0, $v0, $0
		li $v0, 1
		syscall
		add $v0, $t5, $0
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		addu $sp, $sp, 0x0008
		#v0 = 0 bisestile, $v0 = 1 nonBisestile
		add $t4, $t0, $a1
		beq $v0, $0, isBisestile
			sb $0 , 0($t4)
			j next
		isBisestile: sb $t6 , 0($t4)
		next: addiu $t0, $t0, 0x0001
		j for
	done:
	lw $ra, 0($sp)
	addu $sp, $sp, 0x0004
	j $ra 
.end bisestile

.ent modulo
modulo:
	#a0 ricevo un anno, $a1 il valore da testare
	subu $sp, $sp, 4
	sw $s0, 0($sp)
	blt $a0, $a1, doneModulo
	while: 
		subu $a0, $a0, $a1
		bge $a0, $a1, while
		
	doneModulo:
		lw $s0, 0($sp)
		addu $sp, $sp, 4
		add $v0, $0, $a0
		j $ra 
.end modulo
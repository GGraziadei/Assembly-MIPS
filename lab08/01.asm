.data
ora_in:  .byte 12, 14
ora_out: .byte 18, 47
X: 		 .byte 1
Y:       .byte 40
.text
.globl main
main: 
la  $a0, ora_in  # indirizzo di ora_in
la  $a1, ora_out # indirizzo di ora_out
lbu $a2, X
lbu $a3, Y
jal costoParcheggio
add $a0, $v0, $0
li $v0, 1
syscall
li $v0, 10
syscall
.end main
	
.ent costoParcheggio
costoParcheggio:
	addiu $t2, $0, 60
	lbu $t0, 0($a0)
	lbu $t1, 0($a1) #giorno termina alle 23:59
	sub $t0, $t1, $t0
	mul $t0, $t0, $t2
	
	lbu $t1, 1($a0)
	lbu $t2, 1($a1)
	bge $t2 , $t1, invertiDiff
		subu $t1, $t1, $t2
		j fineDiff 
	invertiDiff: subu $t1, $t2, $t1
	
	fineDiff:
	add $t0, $t0, $t1
	add $t1, $0, $0
	
	modulo:
		addiu $t1, $t1, 0x0001
		subu $t0, $t0, $a3 
		bge $t0, $a3, modulo 
	
	mul $t1, $t1, $a3
	
	beq $t0, $0, done
		add $t1, $t1, $a3 
	done:
		add $v0, $0, $t1
		j $ra 

.end costoParcheggio
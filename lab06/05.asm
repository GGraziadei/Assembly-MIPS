.data
n: .word 11
k: .word 8
.text
.globl main
.ent main
main:
	lw $t0 , n
	lw $t1 , k
	sub $t2, $t0, $t1 # ( n, K ) -> (n, n-K) : mi permette allo stesso modo di verificare gli imput
	blt $t2, $0, done
	
	add $a0, $0, $t0
	jal factorial
	add $t0, $v0, $0
	
	add $a0, $0, $t1
	jal factorial
	add $t1, $v0, $0
	
	add $a0, $0, $t2
	jal factorial
	add $t2, $v0, $0
	
	mult $t2,$t1
	mflo $t2
	div $t0,$t2
	mflo $a0
	
	li $v0, 1
	syscall
	
 done:
	li $v0, 10
	syscall
.end main

.ent factorial
factorial:
	bne $a0, $0 , ricorri
	addi $v0 ,$0 , 0x0001
	jr $ra 
	ricorri:
		sub $sp , $sp, 0x0008
		sw $a0, 4($sp)
		sw $ra, 0($sp)
		sub $a0, $a0, 0x0001
		jal factorial
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		add $sp , $sp, 0x0008
		mult $a0, $v0
		mflo $v0
		jr $ra
.end factorial



.data
NP = 20
.text
.globl main
.ent main
main:
	add $t0, $0, 0x0004
	add $t1, $0, 0x0002
	add $t2, $0, -5
	add $t3, $0, 0x0003
	
	#calcolo i valori notevoli
	add $s0, $0, 0x0001
	addiu $s2, $0, 27
	addiu $s3, $0, 9
	sll $s1, $s0, 2
	sll $s4 $s0, 6
	sll $s5 $s0, 4
	sll $s0, $s0, 3
	
	#	$a0 = p(1) = $t0 + $t1 + $t2 + t3
	add $a0, $t0, $t1
	add $a0, $t2, $a0
	add $a0, $a0, $t3 
	
	#	a1 = p(2) = $t0 * $s0 + $t1 * $s1 + $t2 * 2 + $t3
	mul $a1, $t0, $s0
	mul $a2, $t1, $s1
	add $a1, $a1, $a2
	add $a1, $a1, $t3
	sll $a2, $t2, 1
	add $a1, $a1, $a2
	
	#	a2 = p(3) = $t0 * s2 + $t1 * s3 + $t2 * 3 + $t3
	mul $a2, $t0, $s2
	mul $a3, $s3, $t1
	add $a2, $a2, $a3
	add $a2, $a2, $t3
	add $t4, $0 ,3
	mul $t4, $t2, $t4
	add $a2, $a2, $t4
	
	#	a3 = p(4) = $t0 * s4 + $t1 * s5 + $t2 * 4 + t3
	mul $a3, $s4, $t0
	mul $t4, $t1, $s5
	add $a3, $a3, $t4
	add $a3, $a3, $t3
	sll $t4, $t2, 2
	add $a3, $a3, $t4
	
	add $t4, $0, 20
	sub $t5, $t4, 3
	ble $t5, $0, done
	
	##Eseguire una verifica sui dati
	#preservo t0-->t3 quindi 4 * 4byte = 16byte
	#aggiungo N come parametro in cima allo stack 4 byte
	
	sub $sp, $sp, 20
	
	sw $t5, 0($sp) #passo solamente il numero di iterazioni da effettuare
	
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	
	jal pN
	
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	lw $t3, 16($sp)
	
	add $sp, $sp, 20
	
	add $a0, $v0, $0
	li $v0, 1
	syscall
done: 	
	li $v0, 10
	syscall
.end main

.ent pN
pN : 
	lw $t4, 0($sp)
	add $v0, $0, $a3
	sub $sp, $sp, 24
	
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	
	
	sub $t0, $a1, $a0
	sub $t1, $a2, $a1
	sub $t2, $a3, $a2
	
	sub $s0, $t1, $t0
	sub $s1, $t2, $t1
	
	sub $s2, $s1, $s0
	
	while: 
		add $s1, $s1, $s2
		add $t2, $t2, $s1
		add $v0, $v0, $t2
		sub $t4, $t4, 1
		bgt $t4, $0, while
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	add $sp, $sp, 24
	jr $ra
.end pN



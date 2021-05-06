.data 
n1: .word 100000
n2: .word 1000
n3: .word 10
.text
.globl main
.ent main
main:
	la $t0 n1
	lw $t1 ,0($t0)
	
	la $t0 n2
	lw $t2 ,0($t0)
	
	la $t0 n3
	lw $t3 ,0($t0)
if1: bge $t2,$t1, if2
#swap a con b
	add $a0, $t1, $0
	add $a1, $t2, $0
	jal swap
	add $t1, $v0, $0
	add $t2, $v1, $0
if2: bge $t3,$t1, if3
#swap a con c
	add $a0, $t1, $0
	add $a1, $t3, $0
	jal swap
	add $t1, $v0, $0
	add $t3, $v1, $0
if3: bge $t3,$t2, print
#swap b con c
	add $a0, $t2, $0
	add $a1, $t3, $0
	jal swap
	add $t2, $v0, $0
	add $t3, $v1, $0
	
print:
		li $v0,1
		add $a0,$0,$t1
		syscall
		
		li $v0,1
		add $a0,$0,$t2
		syscall
		
		li $v0,1
		add $a0,$0,$t3
		syscall
	
	
li $v0, 10
syscall
.end main

swap: #ricevo a0 ed a1 e li scambio
	add $v0,$zero,$a1
	add $v1,$zero,$a0
	jr $ra
	
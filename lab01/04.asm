.data 
var: .word 0x3FFFFFF0
aCapo: .byte '\n'
.text
.globl main
.ent main
main:
	lw $t1, var
	add $a0, $t1, $0 
	li $v0, 1
	syscall
	la $a0,aCapo
	li $v0, 4
	syscall
	#mul $t3 ,$t1 , 2
	sra $t3 ,$t1 , 2
	add $a0, $t1, $0 
	li $v0, 1
	syscall
	
	addiu $t2,$t1,40
	
	add $a0, $t2, $0 
	li $v0, 1
	syscall
	
	la $a0,aCapo
	li $v0, 4
	syscall
	
	lui $t5,40
	add $a0,$t1,$t5
	li $v0, 1
	syscall

	li $v0, 10
	syscall
.end main
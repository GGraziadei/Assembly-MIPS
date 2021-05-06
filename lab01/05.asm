.data 
res1: .space 4
res2: .space 4

.text
.globl main
.ent main
main:
	li $v0, 5
	syscall
	move $s0,$v0
	
	li $v0, 5
	syscall
	move $s1,$v0
	
	#--------------------
	
	add  $s0,$s0,$s1
	sub  $s1,$s0,$s1
	sub  $s0,$s0,$s1
	
	#--------------------
	
	sw $s0,res1
	sw $s1,res2
	
	
	li $v0, 1
	syscall

	li $v0, 10
	syscall
.end main
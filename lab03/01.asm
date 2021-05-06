.data 
msg1: .asciiz "Inserisci un valore ==>  "
offset: .byte '0'
error: .asciiz "Valore input non valido, inserire solamente cifre numeriche"
.text
.globl main
.ent main
main:
	la $a0 , msg1
	li $v0 , 4
	syscall
	lb $t0, offset
	li $t2, 9
	li $t3, 0
	
while: 
	   li $v0 , 12
	   syscall
	   move $t1,$v0
	   beq $t1,$0,done
	   sub $t1, $t1,$t0
	   bgt $t1,$t2, errorBranch
	   blt $t1,$t3, errorBranch
	   j while
	   	
errorBranch:
	la $a0 , error
	li $v0 , 4
	syscall
done:
	
li $v0, 10
syscall
.end main
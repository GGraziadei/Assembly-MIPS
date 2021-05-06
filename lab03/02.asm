.data 
msg1: .asciiz "Inserisci un valore ==>  "
offset: .byte '0'
error: .asciiz "Valore input non valido, inserire solamente cifre numeriche"
error1: .asciiz "Ho riscontrato Overflow assicurati che il valore stia su 32bit"

.text
.globl main
.ent main
main:
	la $a0 , msg1
	li $v0 , 4
	syscall
	lb $t0, offset
	li $t2, 9
	li $t3, 10
	li $t4, '\n'
	
	add $t5,$0,$0 # t5 = 10 * t5 + valore input
	
while: 
	   li $v0 , 12
	   syscall
	   move $t1,$v0
	   beq $t1,$t4,done #verifica \n 
	   sub $t1, $t1,$t0
	   bgt $t1,$t2, errorBranch
	   blt $t1,$0, errorBranch
	   
	   multu $t5,$t3
	   
	   mfhi $t7
	   bne $0,$t7,errorOverflow
	   
	   mflo $t5
	   add $t5,$t5,$t1
	   j while
	   	
errorBranch:
	la $a0 , error
	li $v0 , 4
	syscall
	#mostra errorre da quale carattere viene generato
	add $a0,$0,$t1
	li $v0 , 11
	syscall
	j done
errorOverflow:
	la $a0 , error1
	li $v0 , 4
	syscall
done:
	add $a0,$0,$t5
	li $v0 , 1
	syscall
	
li $v0, 10
syscall
.end main
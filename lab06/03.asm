.data
str1 : .asciiz "Inserire stringa da convertire in maiuscolo (modalita 1)\n"
msg1 : .asciiz "Inserire stringa da convertire in maiuscolo (modalita 2):\n\t-> "
.text
.globl main
.ent main
main:
	#la $t1,str1 ERRATA CORRIEGE
	add $t2, $0 , $0
	lbu $t0,str1($t2)
Conversione1: beq $t0, $0, done1
	blt $t0, 'a', next1
	add $a0, $t0, $0
	jal toMaiuscolo
	add $t0 ,$v0 ,$0
next1:
add $a0 ,$0 , $t0
li $v0, 11
syscall
addi $t2, $t2, 0x0001
lbu $t0 , str1($t2)
b Conversione1	

done1:
	la $a0, msg1
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	move $t0, $v0
Conversione: beq $t0, $0, done
	blt $t0, 'a', next
	add $a0, $t0, $0
	jal toMaiuscolo
	add $t0 ,$v0 ,$0
next:
add $a0 ,$0 , $t0
li $v0, 11
syscall
li $v0, 12
syscall
move $t0, $v0
b Conversione
	
	
done:	
	li $v0, 10
	syscall
.end main

.ent toMaiuscolo
toMaiuscolo : 
	sub $v0, $a0, 32
	jr $ra
.end toMaiuscolo


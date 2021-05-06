.data 
msg1: .asciiz "Inserisci un valore intero positivo ti dico se pari o dispari: "
msgPari: .asciiz "PARI "
msgDispari: .asciiz "DISPARI "
.text
.globl main
.ent main
main:
	la $a0 , msg1
	li $v0 , 4
	syscall
	
	li $v0 , 5
	syscall
	move $t0, $v0
	
	# verifica se pari => and con 1
	
	andi $t1, $t0 , 1
	li $v0 , 4
	beq $t1 , $zero pari
	la $a0 , msgDispari
	j stampa
pari: 
	la $a0 , msgPari
stampa:
		syscall
	
li $v0, 10
syscall
.end main
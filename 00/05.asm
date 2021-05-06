.data
msg: .asciiz "Inserire la lettera da convertire in maiuscolo: "
.text
 .globl main
 .ent main
 main:
	li $v0, 4
	la $a0, msg
	syscall 
	
	li $v0, 12
	syscall
	move $s1, $v0
	addi $s1, $s1, -32
	
	li $v0,11
	add $a0, $0,$s1
	syscall
	
	li $v0,10 # codice per uscita dal programma
 syscall # fine
 .end main
 
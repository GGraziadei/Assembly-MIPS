#syscall stoppano l'esecuzione e si effettua una chiamata direttamente al sistema operativo
#se syscall ha un output questo viene memorizzato in $v0

 .data
msg1: .asciiz "introduci il primo valore: " 
#direttiva per assemblatore, occorre per dichiarare una stringa, se non inserisco la z finale non posso terminare la stringa
msg2: .asciiz "introduci il secondo valore: "
 .text
 .globl main
 .ent main
main: 
	#Stampa messaggio1 per chiedere l'inserimento di un intero
	li $v0, 4 # syscall 4 (print_str)
	la $a0, msg1 # argomento della syscall: stringa
	syscall # stampa la stringa
	
	#Acquisisci intero
	li $v0, 5 # syscall 5 (read_int)
	syscall
	move $s1, $v0 # primo operando
 
	li $v0, 4
	la $a0, msg2
	syscall
		
	li $v0, 5
	syscall
	
	add $a0, $v0, $s1 # somma degli operandi
 
	li $v0, 1 # syscall 1 (print_int)
	syscall

li $v0,10 # codice per uscita dal programma
 syscall # fine
 .end main
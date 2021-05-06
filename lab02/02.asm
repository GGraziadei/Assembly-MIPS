.data 
msg1: .asciiz "Inserisci un valore intero positivo: "
msgError: .asciiz "errore ! "
.text
.globl main
.ent main
main:

	#Salvo i due valori in s0 e s1
	
	la $a0 , msg1
	li $v0 , 4
	syscall
	
	li $v0 , 5
	syscall
	move $s0, $v0
	
	la $a0 , msg1
	li $v0 , 4
	syscall
	
	li $v0 , 5
	syscall
	move $s1, $v0
	
	# verifica se sono su un byte tramite uno shift 
	# 0000 0000 0001 0101 
	# 0000 0000 0000 0001 != 0x0
	# oppure posso utilizzare una operazione and bitwise con 
	# 1111 1111 1111 0000
	
	and $t0 , $s0, 0xFFFFFF00
	bne $0, $t0 error
	
	and $t0, $s1, 0xFFFFFF00
	bne $0, $t0 error
	
	#Di seguito espressione booleana, la quale deve tornare 255
	# A = s0 B = s1
	not $t2, $s1
	and $t3, $t2, $s0
	not $t3,$t3
	
	xor $t1, $s0,$s1
	
	or $t1,$t1,$t3
	
	and $t1, $t1,0xFF
	
	addu $a0, $zero,$t1
	li $v0 , 4
	syscall
	
	j done

error:
	la $a0 , msgError
	li $v0 , 4
	syscall
done:
	
li $v0, 10
syscall
.end main
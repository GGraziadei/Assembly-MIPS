#Che valore è visualizzato se il numero è un intero senza
#segno compreso fra 2^31 e 2^32 – 1?
# numero in CA2
.data
var1: .word 3141592653
INT_2_CHAR = '0'
.text
.globl main
.ent main
main:
	lw $t0,var1
	add $t1,$0,$0 #$t1 ha funzione di indice di calcolo
	add $t2,$0,$0 #$t2 = j
	addu $t3,$0,10
	li $v0, 11 #mi configuro per stampaStack
	
while: beq $t0,$0,stampaStack
	   addi $t1,$t1,0x0001
	   sub $sp,$sp,4 # $sp = $sp -4
	   divu $t0,$t3
	   mflo $t0
	   mfhi $t4
	   sw $t4,0($sp)
	   j while
	   
stampaStack: bge $t2,$t1,done
			 addi $t2,$t2,0x0001
			 lw $t3,0($sp)
			 addu $sp,$sp,4
			 add $t3,$t3,INT_2_CHAR
			 add $a0,$t3,$0
			 syscall
			 j stampaStack
	
done:	
	li $v0, 10
	syscall
.end main
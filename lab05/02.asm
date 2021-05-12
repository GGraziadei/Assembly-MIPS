.data
palindorma: .asciiz "Hai inserito una parola palindroma"
nonPalindroma: .asciiz "Hai inserito una parola non palindroma"
fineStringa = '\n'
.text
.globl main
.ent main
main:
	add $t1,$0,$0 #$t1 indice i=0
	add $t0,$0,$0
	li $v0,12
move $s1,$sp #backup dello stack

leggiChar: syscall
		   beq $v0,fineStringa,isPalindroma
		   addi $t1,$t1,0x0001
		   sub $sp,$sp,4
		   sw $v0,0($sp)	
		   li $v0,12
b leggiChar
	
isPalindroma:
	addi $t0,$0,0x0002
	div $t1,$t0
	mflo $t2 #t2 conta il numero esatto di operazioni da eseguire
	add $t0,$0,$0 #t0 indice della operazione
	move $s0,$sp
checkPalindroma: bge $t0, $t2, return
				 addi $t0,$t0,0x0001
				 lw $t6, 0($sp)
				 sub $t7, $t1, $t0 #numero di word da saltare
				 sll $t7, $t7,2 #numero di byte da saltare
				 add $t7,$t7,$s0
				 lw $t7, 0($t7)
				 add $sp, $sp, 0x0004
				 bne $t7,$t6, nonPalindromaException #condizione di uscita incondizionata
				 b checkPalindroma
return:	
	la $a0,palindorma
	b done
nonPalindromaException: la $a0,nonPalindroma
done: 
	li $v0, 4
	syscall
	move $sp,$s1
	li $v0, 10
	syscall
.end main
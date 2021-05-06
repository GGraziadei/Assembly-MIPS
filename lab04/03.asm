.data 
riga: .word 1, 2, 3, 4
colonna: .word -1, -2, 6, 7
result: .space 64
DIM = 4
.text
.globl main
.ent main

main:
	add $t3,$0,$0 # $t3 = i = 0	
forRiga: bge $t3,DIM,exit
	add $t4,$0,$0 # $t4 = j = 0
	sll $t6,$t3,2
	lw $t6,riga($t6)
	forColonna:  bge $t4,DIM,done
				sll $t7,$t4,2
				lw $t7,colonna($t7)
				mul $t5,$t6,$t7
				mul $t7,$t3,DIM # $t7 = riga*DIM
				add $t7,$t7,$t4 #offset $t7 = riga*DIM + colonna
				sll $t7,$t7,2
				sw $t5, result($t7)
				addi $t4,$t4,0x0001
				j forColonna		
	done: addi $t3,$t3,0x0001
	j forRiga
	
exit:	
li $v0, 10
syscall
.end main

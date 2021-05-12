.data
matrix: .word 1 2 3 4 5
		.word 2 3 4 5 6
		.word 3 4 5 6 7
		.word 4 5 6 7 8
		.word 5 6 7 8 9	 
DIM = 5
msg1 : .asciiz "Risultato
				\t- 2 se la matrice è diagonale\n
				\t– 1 se la matrice è simmetrica\n
				\t– 0 se la matrice non è simmetrica\n"
.text
.globl main
.ent main
main:
	addi $s0,$0,0x0001 #simmetrica
	addi $s1,$0,0x0001 #diagonale
	
	add $t1,$0,$0 #i
	add $t2,$0,$0 #j
	
forEsterno: bge $t1,DIM,doneInfo
	#### RIGA ####
	add $t3, $s1,$s0
	beq $t3,$0,doneInfo
		forInterno: bge $t2,DIM,fineRiga
		#### COLONNA ####
		mul $t5,$t1,DIM
		add $t5,$t2,$t5
		sll $t5,$t5,2
		lw $t5, matrix($t5)
		beq $t1,$t2,fineControlloSimm
			bne $s1,0x0001, fineControlloDiag
				#Controllo se diagonale
				beq $t5,$0,fineControlloDiag
				add $s1,$0,$0
		fineControlloDiag:
		beq $s0,0x0001, fineControlloSimm
		mul $t4,$t2,DIM
		add $t4,$t1,$t4
		sll $t5,$t5,2
		lw $t4, matrix($t4)	
		beq $t4,$t5,fineControlloSimm
		add $s0,$0,$0
		fineControlloSimm:
			addi $t2,$t2,0x0001
			b forInterno
fineRiga:		
	addi $t1,$t1,0x0001
	b forEsterno

doneInfo:
la $a0,msg1
li $v0,4 
syscall
li $v0,1
add $a0,$0,$s1
syscall
bne $s0,0x0001,return
addi $a0,$0,0x0002
syscall
return: 
	li $v0, 10
	syscall
.end main
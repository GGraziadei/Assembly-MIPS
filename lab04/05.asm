.data 
matrix: .word 	  154, 123, 109, 86, 4, 0, 
		.word 	  412, -23, -231, 9, 50, 0,
		.word	  123, -24, 12, 55, -45, 0,
		.word	  0, 0, 0, 0, 0, 0
DIM = 6
DIM_C = 5
DIM_R = 3
offset = 18 
.text
.globl main
.ent main

main:
	add $t3,$0,$0 # $t3 = i = 0	
forRiga: bge $t3,DIM_R,exit
	add $t4,$0,$0 # $t4 = j = 0
	add $t6, $0,$0 # conta riga 
	forColonna: bge $t4,DIM_C,done
				mul $t7,$t3,DIM # $t7 = riga*DIM
				add $t7,$t7,$t4 #offset $t7 = riga*DIM + colonna
				sll $t7,$t7,2 
				lw $t7, matrix($t7) # valore cella 
				
				add $t6,$t6,$t7 # utilizzo t6 per propagare la somma sulla riga
				
				add $t0,$t4,offset
				sll $t0,$t0,2
				lw $t1, matrix($t0)
				add $t1,$t7,$t1
				sw  $t1, matrix($t0)
				
				addi $t4,$t4,0x0001
				j forColonna		
	done:
	mul $t7,$t3,DIM # $t7 = riga*DIM
    add $t7,$t7,$t4 #offset $t7 = riga*DIM + colonna
	sll $t7,$t7,2
	sw $t6, matrix($t7)
	add $t0,$t4,offset
	sll $t0,$t0,2
	lw $t1, matrix($t0)
	add $t1,$t6,$t1
	sw  $t1, matrix($t0)	
	addi $t3,$t3,0x0001
	j forRiga
	
exit:	
li $v0, 10
syscall
.end main
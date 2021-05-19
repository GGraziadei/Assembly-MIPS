.data
msg1 : .asciiz "Inserire lato del triangolo / quadrato\n\t->"
carattereStampa = '*'
aCapo = '\n'
spazio = ' '
.text
.globl main
.ent main
main:
	addi $t0,$0,0x0001
	
	la $a0,msg1
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a1, $v0
	
	add  $a0,$0,$t0
	#addi $a1,$0,23
	jal stampaTriangolo
	
	add  $a0,$0,$t0
	#addi $a1,$0,23
	jal stampaQuadrato
done:	
	li $v0, 10
	syscall
.end main

.ent stampaTriangolo
stampaTriangolo : 
	bne $a0, $a1, procediStampa
		jr $ra
	procediStampa:
		# a0 mi dice quanti * devo stampare
		li $v0, 11
		add $t1, $0, $0
		add $t2, $0, $a0
		forT: bge $t1,$t2,proxRigaTriangolo
			add $a0,$0,carattereStampa
			syscall
			add $a0,$0,spazio
			syscall
			addi $t1, $t1, 0x0001
			b forT
		proxRigaTriangolo:
			add $a0,$0,aCapo
			syscall
			add $a0, $t2, 0x0001
			sub $sp, $sp, 0x0004 # sp - 4 e salvo indirizzo di ritorno
			sw $ra, 0($sp)	
			jal stampaTriangolo
		lw $ra, 0($sp)	
		add $sp, $sp, 0x0004
		jr $ra
.end stampaTriangolo


.ent stampaQuadrato
stampaQuadrato : 
	bne $a0, $a1, procediStampaQ
		jr $ra
	procediStampaQ:
		# a0 mi dice quanti * devo stampare
		li $v0, 11
		add $t1, $0, $0
		add $t2, $0, $a0
		#addi $t3, $0, LATO_QUADRATO
		forQ: bge $t1, $a1, proxRigaQuadrato
			add $a0,$0,carattereStampa
			syscall
			add $a0,$0,spazio
			syscall
			addi $t1, $t1, 0x0001
			b forQ
		proxRigaQuadrato:
			add $a0,$0,aCapo
			syscall
			add $a0, $t2, 0x0001
			sub $sp, $sp, 0x0004 # sp - 4 e salvo indirizzo di ritorno
			sw $ra, 0($sp)	
			jal stampaQuadrato
		lw $ra, 0($sp)	
		add $sp, $sp, 0x0004
		jr $ra
.end stampaQuadrato
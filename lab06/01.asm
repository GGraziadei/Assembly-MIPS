.data
carattereStampa = '*'
aCapo = '\n'
spazio = ' '
LATO_TRIANGOLO = 8
LATO_QUADRATO = 8
.text
.globl main
.ent main
main:
	addi $t0,$0,0x0001
	add $a0,$0,$t0
	jal stampaTriangolo
	add $a0,$0,$t0
	jal stampaQuadrato
	
	
done:	
	li $v0, 10
	syscall
.end main

.ent stampaTriangolo
stampaTriangolo : 
	bne $a0, LATO_TRIANGOLO, procediStampa
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
	bne $a0, LATO_QUADRATO, procediStampaQ
		jr $ra
	procediStampaQ:
		# a0 mi dice quanti * devo stampare
		li $v0, 11
		add $t1, $0, $0
		add $t2, $0, $a0
		addi $t3, $0, LATO_QUADRATO
		forQ: bge $t1, $t3, proxRigaQuadrato
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
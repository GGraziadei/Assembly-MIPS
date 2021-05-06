.data 
tabella: .word somma,sottrazione,moltiplicazione,divisioneInt
opa: .word 2043
opb: .word 5
res: .space 4

.text
.globl main
.ent main
main:
	lw $t4, opa
	lw $t5, opb
	la $t3, res 

	li $v0, 5
	syscall
	move $t1,$v0
	li $t2, 4
	blt $t1,$0,err
	bge $t1,$t2,err
	sll $t1,$t1,2 # t1 = t1 * 4
	lw $t0,tabella($t1)
	jr $t0
	
somma:
add $t4,$t4,$t5
sw $t4, 0($t3)
j err
sottrazione:
sub $t4,$t4,$t5
sw $t4, 0($t3)
j err
moltiplicazione:
mult $t4,$t5 #sto operando su byte quindi non ho overflow
mflo $t4
sw $t4, 0($t3)
j err
divisioneInt:
div $t4,$t5
mflo $t4
sw $t4, 0($t3)
	
	
err:
li $v0, 10
syscall
.end main
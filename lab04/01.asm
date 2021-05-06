.data 
vett: .space 80

.text
.globl main
.ent main
main:
	la $t0, vett
	li $t1, 1
	sw $t1, 0($t0)
	add $t0,$t0,4
	li $t2, 1 
	sw $t2, 0($t0)
	add $t0,$t0,4 
	li $t3, 2 # $t3 = contatore
	
while: bge $t3,20 done
	add $t4,$t1,$t2
	sw $t4, 0($t0)
	add $t0,$t0,4
	add $t1,$0,$t2
	add $t2,$0,$t4
	add $t3,$t3,1
	j while
	
done: la $t0, vett
	add $t3,$0,$0
	add $t2,$0,$0
	li $v0, 1
	
	
whilePrint: bge $t3,20 fine
	add $t0,$t0,$t2
	lw $t4, 0($t0)
	add $a0,$0,$t4
	syscall
	add $t2,$0,4
	add $t3,$t3,1
	j whilePrint
		  
fine:		
li $v0, 10
syscall
.end main
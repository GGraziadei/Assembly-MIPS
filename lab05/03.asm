.data
msg1 : .asciiz "Inserire valori Ax^2 + Bx + C = 0 [A B C] : \n"
soluzioni: .asciiz "Esiste almeno una soluzione"
noSoluzioni: .asciiz "Non esiste alcuna soluzione"

.text
.globl main
.ent main
main:
	li $v0, 4
	la $a0,msg1
	syscall
	
	li $v0, 5
	syscall
	move $t4,$v0 #a
	li $v0, 5
	syscall
	move $t5,$v0 #b
	li $v0, 5
	syscall
	move $t6,$v0 #c
	
	mul $t0, $t5, $t5
	
	mul $t1,$t4,$t6
	
	sll $t1,$t1,2
	
	sub $t0,$t0,$t1
	li $v0,4
	
	slt $t0, $t0,$0
	beq $t0,$0, sol
	
	la $a0,noSoluzioni 
     b done
sol: la $a0,soluzioni 
done: syscall
	
	li $v0, 10
	syscall
.end main
.data 
n1: .byte 150
n2: .byte 100

.text
.globl main
.ent main
main:
	lbu $t1, n1
	lbu $t2, n2
	
	add $a0, $t1, $t2 
#in quanto 150 per assemblatore viene visto in CA2 
# con la u è unsigned	
	li $v0, 1
	syscall

	li $v0, 10
	syscall
.end main
.data
res: .space 1
.text
.globl main
main: 
	addiu $t0, $0, 0x0001
	addiu $t1, $0, 10000
	la $t2, res
	sb $t0, 0($t2)
	sb $t1, 0($t2)
	
li $v0, 10
syscall
.end main

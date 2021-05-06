.data 
n1: .byte 10
n2: .byte 0x10
n3: .byte '1'
res: .space 1 #riserva 1 bye per questa variabile

.text
.globl main
.ent main
main:
	lb $t1, n1
	lb $t2, n2
	sub $t3, $t1, $t2
	lb $t1, n3
	add $t3, $t1, $t3

li $v0, 10
syscall
.end main
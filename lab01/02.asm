.data
var1: .byte 'm'
var2: .byte 'i'
var3: .byte 'p'
var4: .byte 's'
var5: .byte 0

.text
.globl main
.ent main
main:
lb $t1, var1
addi $t1,$t1,-0x20
sb $t1,var1

lb $t2, var2
addi $t2,$t2,-0x20
sb $t2,var2

lb $t3, var3
addi $t3,$t3,-0x20
sb $t3,var3

lb $t4, var4
addi $t4,$t4,-0x20
sb $t4,var4

li $v0, 4
la $a0, var1
syscall
li $v0, 10
syscall
.end main
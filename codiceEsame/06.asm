.data
ora_in: .byte 12, 47
ora_out: .byte 18, 14
X: .byte 1
Y: .byte 40
.text
.globl main
.ent main
main: sub $sp, $sp, 4
sw $ra, ($sp)
la $a0, ora_in # indirizzo di ora_in
la $a1, ora_out # indirizzo di ora_out
lbu $a2, X
lbu $a3, Y
jal costoParcheggio
lw $ra, ($sp)
addiu $sp, $sp, 4
jr $ra
.end main

.ent costoParcheggio
costoParcheggio:
subu $sp, $sp, 12
sw $s0, 8($sp)
sw $s1, 4($sp)
sw $s2, 0($sp)

and $t0, $0, $0
addiu $t3, $0, 60

#s1 = variabile in s2 = varibile timestamp out

lb $t1, 0($a0)
lb $t2, 1($a0)
mult $t1, $t3
mflo $t1 
add $s1, $t1, $t2

lb $t1, 0($a1)
lb $t2, 1($a1)
mult $t1, $t3
mflo $t1 
add $s2, $t1, $t2

sub $s0, $s2, $s1 #offset timestamp 
modulo: sub $s0, $s0, $a3
		addiu $t0, $t0, 0x0001
		bgt $s0, $a3, modulo
mult $t0, $a2
mflo $v0

fine:
lw $s2, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
addiu $sp, $sp, 12
jr $ra
.end costoParcheggio
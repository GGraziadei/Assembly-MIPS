NUM = 5
DIM = NUM * 4
SCONTO = 30
ARROTONDA = 1
.data
prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM
totSconto: .space 4
.text
.globl main
.ent main
main: subu $sp, $sp, 4
sw $ra, ($sp)
la $a0, prezzi
la $a1, scontati
li $a2, NUM
li $a3, SCONTO
li $t0, ARROTONDA
subu $sp, $sp, 4
sw $t0, ($sp)
jal calcola_sconto
sw $v0, totSconto
lw $ra, 4($sp)
addiu $sp, $sp, 8
jr $ra
.end main

.ent calcola_sconto
calcola_sconto:
lw $t0, 0($sp)
and $v0, $0, $0 #contatore sconto
and $t1, $0, $0 #indice del ciclo

li $t3, 100
li $t5, 50

div $a3, $t3
mfhi $a3

ciclo: bge $t1, $a2, fine
lw $t2, 0($a0)
add $t6, $0, $t2
addiu $a0, $a0, 0x0004

mul $t2, $t2, $a3
div $t2, $t3
mflo $t2

beq $t0, $0, noArrotonda
mfhi $t4
bge $t4, $t5, noArrotonda #ragionando al contrario risparmio 2 istruzioni
addiu $t2, $t2, 0x0001

noArrotonda:
sub $t6, $t6, $t2
sw $t6, 0($a1)
add $v0, $v0, $t2
addiu $a1, $a1, 0x0004
addiu $t1, $t1, 0x0001
j ciclo

fine: jr $ra
.end calcola_sconto
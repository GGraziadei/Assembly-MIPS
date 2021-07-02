DIM = 11
.data
veta: .word 2, 14, 8, 54, 0, 42, 9, 24, 0, 91, 23
vetb: .byte 4*DIM
.text
.globl main
.ent main
main: 
la $a0, veta
la $a1, vetb
li $a2, DIM
jal media
li $v0,10
syscall
.end main

.ent media
media:
addi $t0, $a2, -3
ble $t0, $0, fine #errore input non corretto
addiu $t4, $0, 0x0004

lw $t1, 0($a0)
andi $t1, $t1, 0x00FF #seleziono 1B esplicitamente
lw $t2, 4($a0)
andi $t2, $t2, 0x00FF #seleziono 1B esplicitamente
addiu $a0, $a0, 0x0008

sw $t1, 0($a1)
sw $t2, 4($a1) 
addiu $a1, $a1, 0x0008

ciclo: 
	lw $t6, 0($a0)
	add $t3, $a0, 0x0004
	add $t5, $t1, $t6
	add $t5, $t2, $t5
	lw $t3, 0($t3)
	add $t5, $t5, $t3
	div $t5, $t5, $t4
	andi $t5, $t5, 0x00FF #seleziono 1B esplicitamente
	sw $t5, 0($a1)
	move $t1, $t2
	move $t2, $t6
addiu $a1, $a1, 0x0004	
addiu $a0, $a0, 0x0004
addi $t0, $t0, -1
bne $t0, $0, ciclo #il numero delle istruzioni permette il salto condizionato

lw $t1, 0($a0)
sb $t1, 0($a1)

fine: jr $ra
.end media
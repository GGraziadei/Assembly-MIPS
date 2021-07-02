.data
str_orig: .asciiz "% nella citta' dolente, % nell'eterno dolore, % tra la perduta gente "
str_sost: .asciiz "per me si va"
str_new: .space 200
.text
.globl main
.ent main
main: subu $sp, 4
sw $ra, ($sp)
la $a0, str_orig
la $a1, str_sost
la $a2, str_new
jal sostituisci
la $a0, str_new
li $v0, 4
syscall
lw $ra, ($sp)
addiu $sp, 4
jr $ra
.end main

.ent sostituisci
sostituisci:
and $v0, $0, $0
add $t0, $0, '%'

ciclo:
lb $t1, 0($a0)
beq $t1, $0, fineCiclo #se \n ho completato l'eleaborazione
addiu $a0, $a0, 0x0001
bne $t1, $t0, noAddStringa
add $t2, $0, $a1
cicloInterno: lb $t3, 0($t2)
addiu $t2, $t2,0x0001
beq $t3, $0, ciclo
sb $t3, 0($a2) 
addiu $a2, $a2, 0x0001
addiu $v0, $v0, 0x0001
j cicloInterno			  
noAddStringa: addiu $v0, $v0, 0x0001
sb $t1, 0($a2) 
addiu $a2, $a2, 0x0001
j ciclo	
fineCiclo: sb $0, 0($a2)
jr $ra
.end sostituisci


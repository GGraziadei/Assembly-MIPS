.data
err_mess: .asciiz "Introdurre valori compresi tra 0 e 255"
.text
.globl main
.ent main
main: li $t1, 0xFFFFFF00
li $v0, 5
syscall
and $t2, $v0, $t1 # A in $t0
bne $t2, 0, errore
move $t0, $v0
li $v0, 5
syscall
and $t2, $v0, $t1 # B in $t1
bne $t2, 0, errore
move $t1, $v0
not $t3, $t1 # not B
and $t3, $t0, $t3 # A and (not B)
not $t3, $t3 # not (A and (not B))
xor $t0, $t0, $t1 # A xor B
or $t0, $t0, $t3 # not (A and (not B)) or (A xor B)
li $t1, 0x000000FF # azzeramento della parte più significativa
and $t0, $t0, $t1 # del risultato prima della stampa
move $a0, $t0
li $v0, 1
syscall
j fine
errore: la, $a0, err_mess
li $v0, 4
syscall
fine: li $v0, 10
syscall
.end main
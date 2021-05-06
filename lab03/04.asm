.data
msg1: .asciiz "Inserisci un valore -> "
msg2: .asciiz ",\n"
DIM = 3
.text

.globl main
.ent main
	main:
	add $t0,$0,$0 # $t0 = 0 contatore
	add $t1,$0,$0 # $t1 = 0
for: beq $t0,DIM,done # i = 10 -> esci dal for
	 addi $t0,$t0,1
	 la $a0,msg1
	 li $v0,4
	 syscall
	 li $v0,5
	 syscall
	 add $t1,$t1,$v0
	 j for
	
done:
		divu $t1,$t1,DIM
		li $v0, 1
		mflo $a0
		syscall
		li $v0, 4
		la $a0,msg2
		syscall
		li $v0, 1
		mfhi $a0
		syscall
		

li $v0, 10
syscall
.end main
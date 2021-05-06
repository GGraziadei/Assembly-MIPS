.data
volume: .space 4 # int variabile
b1: .space 4
b2: .space 4
h: .space 4
.text
.globl main
.ent main
main:
	li $t0, 10
	sw $t0, h
	li $t0, 15
	sw $t0, b1
	li $t0, 30
	sw $t0, b2
	mul volume, b1, b2
	mul volume, volume, h
	li $v0, 10
	syscall
.end main
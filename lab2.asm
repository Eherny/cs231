	.data
str1: 	.asciiz "================================================================================\n"

str2:	.asciiz"Program Description\t\t A simple program to output a string and integer\n"

str3:	.asciiz "Author:\t\t\t\tEric Hernandez\n"

str4:	.asciiz "Creator Date\t\t\t02/02/2022\n"

str5:   .asciiz "The course number\t\t"

str6: 	.asciiz "\n"

str7:	.asciiz "The year in program\t\t "

str8: 	.asciiz "================================================================================"
		
	
	.text
	
	
	li  $v0,4
	la  $a0,str1
	syscall
	
	li  $v0,4
	la  $a0,str2
	syscall
	li  $v0,4
	la  $a0,str3
	syscall
	
	li  $v0,4
	la  $a0,str4
	syscall
	
	li  $v0,4
	la  $a0,str5
	syscall
	
	li $v0,1
	la $a0,231
	syscall
	
	li  $v0,4
	la  $a0,str6
	syscall
	
	li  $v0,4
	la  $a0,str7
	syscall
	
	li $v0,1
	la $a0,3
	syscall
	
	
	li  $v0,4
	la  $a0,str6
	syscall
	
	li $v0,10
	syscall
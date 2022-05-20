.data
describ: .asciiz "Program Description:\t\tThis purpose of this program is to simulate a grocery store using arrays\n"
auth: .asciiz "Author:\t\tEric Hernandez\n"
date: .asciiz "Date:\t\t03/12/2022\n"
course: .asciiz "Course number:\t\t231\n"
itemprompt: .asciiz "Please enter the number of items you are purchasing: "
str: .asciiz "=========================================================\n"
items: .asciiz "Please enter the price of item "
items2: .asciiz ":\t"
couponprompt: .asciiz "Please enter the number of coupons you would like to use\n"
coupons: .asciiz "Please enter the amount of coupon "
total: .asciiz "Your total charge is:\t$"
thanks: .asciiz "Thank you for shopping with us"
ierror: .asciiz "Sorry,too many items to purchase\n"
cerror: .asciiz "Invalid amount of coupons!\n"
errors: .asciiz "This coupons is not acceptable\n"
new: .asciiz "\n"
itemArray: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
couponArray: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.text
title:
li $v0,4
la $a0,str	#prints =========
syscall

li $v0,4
la $a0,describ	#prints desciption
syscall

li $v0,4
la $a0,auth	#prints author name
syscall

li $v0,4
la $a0,date	#prints date worked on
syscall

li $v0,4
la $a0,course	#prints course number
syscall
li $v0,4
la $a0,str	#prints =====
syscall
main:

li $v0,4
la $a0,itemprompt	#prompts how many items
syscall

li $v0,5	#takes in user input
syscall

bgt $v0,20,error	#checks if items are greater than 20
add $a1,$v0,$0	#adds input into $a1

li $v0,4	#seperates with ============
la $a0,str
syscall

jal fillpricearray	##calls fillprice array subroutine
add $s4,$v1,$0
li $v0,4
la $a0,str
syscall 

main2:	#next main
li $v0,4	 
la $a0,couponprompt	#prompts how many coupon the user wants to add
syscall

li $v0,5	#prompts user input for coupons
syscall

bne $v0,$a1,error2	#checks if user wants to add the same amount of coupons as items

add $a2,$v0,0	#if it passes add user input into $a2

jal FillCouponArray	#calls fillcoupon array subroutine
add $s3,$v1,$0
li $v0,4
la $a0,str
syscall
li $v0,4	#shows total charge
la $a0,total
syscall

sub $t2, $s4, $s3	#takes number from first subroutine and subtracts it from second sub and puts it in $t2
li $v0,1	# commands to load an integer
add $a0,$t2,$0	#output of the subtracted variable
syscall

li $v0,4
la $a0,new	#new line
syscall

li $v0,4	#thanks customer
la $a0,thanks
syscall

li $v0,10	#end function
syscall
##########################################FIRST ERROR##########################
error:	#first error if items are greater than 20
li $v0,4
la $a0,ierror
syscall
j main
###############################################################################
####################################SECOND ERROR###########################
error2:
li $v0,4	#second error if amount of coupons are not the same as items
la $a0,cerror
syscall 
j main2
#########################################################################
###################################FILL PRICE ARRAY FUNCTION###############
fillpricearray:
add $t1,$a1,$0  #pass user item input to t1
li $t2,1	#count for number of items
li $t3,0 	#count of items added
la $s0,itemArray	#loads the first point of item array
fill:
beq $t1,$t3,adds	#user input equals the counter branch off
li $v0,4		#asks for the price of item number 1
la $a0,items	
syscall
li $v0,1	#shows the number count
add $a0,$t2,$0
syscall
li $v0,4
la $a0,items2	#shows :\t
syscall

li $v0,5
syscall		#gets user input
add $t4,$v0,$0	#adds user input to $t4
sw $t4,0($s0)	#stores $t4 into array
addi $s0,$s0,4	#incriments the array
addi $t2,$t2,1	#adds to item counter
addi $t3,$t3,1	#incriments the loop counter
j fill
adds:
la $s0,itemArray	#points back to the first element of the array
loop:
beq $t3,$0,exit	#branch  until counter which is at the amount of items, is 0
lw $t1,0($s0)	#loads first element in the array to $t1
addi $s0,$s0,4	#incriments array
add $t7,$t1,$t7	#makes an element called $t7 and add $t7, to items in the array
addi $t3,$t3,-1 #decrements the loop counter
j loop
exit:
add $v1,$t7,$0	#stores final add into $s4
jr $ra	#jumps back to main
###################################################################################
#################################FILL COUPON ARRAY#################################
FillCouponArray:
la $s0,itemArray	#points to first item in the array
la $s1,couponArray	#points to first item in coupon array
li $t1,0	#loads a number for the loop
li $t2,1	#loads a number to count coupons
add $t3,$a2,$0	#stores number of coupons into $t3
loop2:
beq $t1,$t3,addc	#branch once counter is equal to amount of coupons

li $v0,4
la $a0,coupons	#prompt user to enter coupons amount
syscall
li $v0,1	#updates count of coupon numberr
add $a0,$t2,$0
syscall
li $v0,4
la $a0,items2	#outputs :\t
syscall

li $v0,5	#takes coupon amount
syscall

lw $t4,0($s0)	#loads value of item array	
add $t5,$v0,$0	#adds input if to $t5
bge $t5,$t4,error3	#checks if input is greater than $t4
bgt $t5,10,error3	#checks if input is greater than 10
sw $t5,0($s1)	#if it passes stores value in $t5
addi $s0,$s0,4	#incriments item array
addi $s1,$s1,4	#incriments coupon array
addi $t1,$t1,1	#incriments counter for coupons
addi $t2,$t2,1 #incriments number for loop
j loop2
addzeros:
li $t9,0 #load in the value of zero
sw $t9,0($s1)	#store it into coupon array
addi $s0,$s0,4	#incriment array
addi $s1,$s1,4	#incriment array
addi $t1,$t1,1	#incriment counter
addi $t2,$t2,1	#incriment the number coupon
j loop2
addc:
la $s1,couponArray	#loads value of first array
loop3:
beq $t1,$0,exit2	#if counter is equal to 0 exit
lw $t2,0($s1)	#load value in array
add $t8,$t2,$t8	#add #
addi $t1,$t1,-1 #decrement the counter
addi $s1,$s1,4	#incriment the array
j loop3	#jump back to addc
exit2:	#exit function
add $v1,$t8,$0	#save final result to $v1
jr $ra	#jump back to main
#################################ERROR###############
error3:	#error case
li $v0,4	#output array
la $a0,errors
syscall
j addzeros

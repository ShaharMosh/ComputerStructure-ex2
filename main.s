// 208001677 Shahar Moshonov.
	.data
id:	.quad	208001677

	#This is a simple "Hello World!" program
	.section	.rodata	#read only data section
format2:	.string	"%ld\n"	#a*2^c
str:	.string	"208001677\n"
	########
	.text	#the beginnig of the code
.globl	main	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function
main:
    movq %rsp, %rbp #for correct debugging	# the main function:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp,	%rbp	#create the new frame pointer

	movq	$str,%rdi	#the string is the only paramter passed to the printf function (remember- first parameter goes in %rdi).
	movq	$0,%rax
	call	printf		#calling to printf AFTER we passed its parameters.

	#return from printf:
	movq	$0, %rax	#return value is zero (just like in c - we tell the OS that this program finished seccessfully)
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)

	movq	id, %rsi	#assign a to %rsi (1000)   
     

       
    	#passing all the parameters for printf - from the last to the first (FIFO!), note the register usage
	#note that the sum is already in %rcx (4th argument), b is already in %rdx (3rd argument)
	movq	$format2,%rdi	#the string is the first paramter passed to the printf function.
	movq	$0,%rax
       pushq	$0x41		#pushing a random value to the stack (causing the stack to be 16 byte aligned)
	call	printf		#calling to printf AFTER its arguments are passed (not that many arguments, therefore using registers only).
       ret
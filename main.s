// 208001677 Shahar Moshonov

#This is the ex2 program.
	.data
id:	.quad	208001677 
	
	.section	.rodata	 #read only data section
format:	.string	"%qd\n" #print format of number.
true:  .string       "True\n"       #True string
false:  .string       "False\n"     #False string
	########
	.text	
.globl	main	#the label "main"
	.type	main, @function
main:
       movq   %rsp, %rbp    
	pushq	%rbp		#save the old frame pointer
	movq	%rsp,	%rbp	#create the new frame pointer

##first task##
       movq	id, %rsi	#assign id to %rsi.
	movq	$format, %rdi	#move the print format in order to print id number.
	movq	$0,%rax
	call	printf		#calling to printf after we passed its parameters.

##second task##
	movq	$id, %rsi	#geting the address of label "id".
	movb	1(%rsi), %al	#geting the second byte of id in binary.
       movq   $1, %rbx      #save 1 in %rbx.
       test   %rax, %rbx    #do 1&the second byte- in order ti check if the lsb is 1(odd) or 0(even).
       je .l1
       movq   id, %rax	#assign id to %rsi.
       imul   $3, %rsi      #multiply the id by 3.
       jmp .l2
      
.l1:
      movq	id, %rax	  #geting id.
      movq	$3, %rcx        #save 3 in %rcx.
      idivq	%rcx            #divde by 3.
      movq	%rdx, %rsi      #move the reminder to %rsi.
      jmp .l2    
	
.l2:    
    	#passing all the parameters for printf - from the last to the first (FIFO!), note the register usage
	#note that the sum is already in %rcx (4th argument), b is already in %rdx (3rd argument)om	movq	$format2,%rdi	#the string is the first paramter passed to the printf function.	movq	$0,%rax
       movq	$format, %rdi	#the string is the first paramter passed to the printf function.
       movq	$0, %rax
	call	printf		#calling to printf AFTER its arguments are passed (not that many arguments, therefore using registers only).

##third task##
      	movq	$id, %rsi	#geting the address of label "id".    
	movb	2(%rsi), %al	#geting the third byte of id in binary.
       movb	(%rsi), %bl	#geting the first byte of id in binary.
       xor    %al, %bl      #xor between the bytes and save xor_13 in %bl.
       movb   $127, %cl     #save 127 in %cl.
       movsbl %cl, %ecx     #extend the value in %cl to %ecx.
       movsbl %bl, %ebx     #extend the value in %bl to %ebx.
       cmpl   %ecx, %ebx    #check if dec_unsigned_13 - 127 < 0.
       jb .l3
       movq	$true,%rdi	#if dec_unsigned_13 - 127 > 0 we print True.
       jmp .l4
.l3:
      	movq	$false,%rdi	#if dec_unsigned_13 - 127 < 0 we print False. 
       jmp .l4

.l4:     
      	movq	$0, %rax
	call	printf		#calling to printf after we passed its parameters.


##fourth task##
      	movq	$id, %rsi	#geting the address of label "id".    
	movsbq	3(%rsi), %rax	#geting the fourth byte of id in binary.
       movq    $0, %rcx     #initialize i=0.
       movq    $0, %rdi     #initialize the counter of 1's in the fourth byte.
       movq    $1, %rbx     #save 1 in %rbx.
  
.l5:
       incq    %rcx         #i++.
       and     %rax, %rbx
       je .l6
       incq    %rdi
       salq    $1, %rbx
       cmp     $7, %rcx
       jle .l5 

.l6:
       movq    $1, %rbx      #save 1 in %rbx.
       salq    %rcx, %rbx
       cmp     $7, %rcx
       jle .l5      

       
       movq   %rdi, %rsi    #move the number if 1's of the fourth byte to %rsi.
       movq   $format, %rdi
       call	printf		#calling to printf after we passed its parameters

	#return from printf - end of program:
	movq	$0, %rax	#return value is zero.
	movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).

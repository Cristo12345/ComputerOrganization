  # Christian Suleiman
  # GCD Recursive
  
  li $a0, 44 #load values into registers
  li $a1, 8
  li $a2, 0 # hold the result/temp
  
  sub $sp,$sp,16 # creating space on stack for 4 4-bytes of data (return address, a, b, res)
  
  sw $ra,0($sp) #storing values in registers into newly created space on stack
  sw $a0,4($sp)
  sw $a1,8($sp)
  sw $a2,12($sp)
  
  jal gcd #call gcd function
  sw $t0,12($sp) # save return address
  j EXIT

gcd:
  # a0 and a1 are the two integer parameters, assuming a0 > a1 and a0, a1 > 0
  sub $sp,$sp,12
  sw $ra,0($sp)
  sw $a0,4($sp)
  sw $a1,8($sp)
  move $t0, $a0
  move $t1, $a1
  
#loop:
  beq $t1, $0, done #if second arg(a0 % a1) is 0 we are finished
  div $t0, $t1 #divide our operands . . . Quotient gets sent to LO and remainder gets sent to HI
  move $t0, $t1 # a = b in euclid's algorithm
  mfhi $t1 # b = remainder
  move $a1,$t1
  move $a0,$t0
  jal gcd #return to start of loop
done: #essentially a loop of returning to the return address once solution is met
  lw $ra,0($sp) # loading top of stack pointer into $ra
  addi $sp,$sp,12 # deallocating space we used to store local variables 
  jr $ra
EXIT:
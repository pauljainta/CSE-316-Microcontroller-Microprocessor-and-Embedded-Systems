.model small
.stack 100h
.data  

N dw ?
K dw ?
X db ?
Y dw ?        
itr dw ?



.code

proc main 
    
    ;input n
    loop_for:
    
   
	MOV Y,0
	MOV X,10
       
    
       INPUT_N:
       MOV AH,1
       INT 21H 
       cmp al,'$'
       je exit 
       CMP AL,' '
       JNE NUMBER_N
       
       
      
	   MOV Y,0
	  MOV X,10
       
       
       JMP INPUT_K
       
       
       NUMBER_N:
       SUB AL,30H
       mov ah,0
       add Y,ax 
       
       mov ax,Y
        
       MUL X
       
       
       mov bx,Y 
       MOV N,BX
       mov Y,ax
       
       JMP INPUT_N
    ;input k   
	   
	   
	
       
    
       INPUT_K: 
       
       
       
       MOV AH,1
       INT 21H
       CMP AL,' '
       JNE NUMBER_K 
       
      
       
       JMP PROCESS
       
       
       NUMBER_K:
      SUB AL,30H
       mov ah,0
       add Y,ax 
       
       mov ax,Y
        
       MUL X
       
       
       mov bx,Y 
       MOV K,BX
       mov Y,ax
       
       
       JMP INPUT_K
       
       
       PROCESS:
       
      MOV dl, 10
      MOV ah, 2
      INT 21h
      MOV dl, 13
      MOV ah, 2
      INT 21h 
      
      mov bx,N
      mov ax,N
      xor dx,dx
      dec K    
      dec ax
      div K
      add bx,ax 
       
      ;dec print
      mov cx,5
       
       DecPrint: 
    
       
        cmp cx,1
        JE level1
        cmp cx,2
        JE level2
        cmp cx,3
        JE level3
        cmp cx,4
        JE level4
        cmp cx ,5
        JE level5
        
        level1: mov itr,1
        jmp msb
        level2: mov itr,10
        jmp msb
        level3: mov itr,100
        jmp msb
        level4: mov itr,1000
        jmp msb       
        level5: mov itr,10000
        jmp msb
        
        msb:
        
        
        mov dx,0
        
        cmp bx,itr    
        jl end_p
        
        repeat:
            sub bx,itr
            inc dx
            cmp bx,itr
            jge repeat
            
        end_p: 
        
        add dx,'0'
        mov ah,2
        int 21h
        
    loop DecPrint
    
      
      
      
      
      
      
      MOV dl, 10
      MOV ah, 2
      INT 21h
      MOV dl, 13
      MOV ah, 2
      INT 21h 
      
      
      jmp loop_for
      
       
      
      
  
      
      
      
      
      
      
	  
	 exit: 
	  
	  
	     
    
    
    main endp
end main




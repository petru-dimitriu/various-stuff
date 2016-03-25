.MODEL small
ORG 100h

.DATA                                                
counts db 100 DUP(0)
array db 5, 48, 3, 15, 4, 2, 2, 9, 10, 5

.CODE

start:
   mov cx, 10        ; load the number of items in array
   lea bx, [array+9] ; go to the end of the array
   
   loop1:        
    mov dl, [bx]     ; load current element from array
    lea ax, counts   ; load the address of the array used for counting
    add ax, dx       ; calculate the corresponding position in the counting array
    push bx          ; i'll use bx to access the memory later, so push the current bx on the stack
    lea bx,ax        ; load the address of the corresponding position in the counting array
    inc [bx]         ; increment
    pop bx           ; pop bx from the stack
    dec bx           ; decrement bx
    dec cx           ; decrement cx
    cmp cx, 0        ; if i have not reached the end of the array
    jnz loop1        ; loop again
   
   ; done with counting the numbers
   ; displaying them follows           
   
   mov si, -1
   lea bx,[counts]  ; i start with the first position in the counting array
   
   array_loop:
   cmp si, 99
   je exit
   
   inc si         
   mov cl, [bx+si]  ; move the contents from the current position to ax
   display_loop: 
    cmp cl, 0        ; if it is zero
    jz array_loop  ; do not display anything
    ; but if it is nonzero
    ; display the current index as many times as the value at the index says
    dec cx
    push cx
    mov ax,si        ; i load the number to display in ax
                     ; because div works with ax          
    
    ; count the digits and place them one by one on the stack                
    mov cx, 0
    display_number:                           
        mov dl, 10
        div dl       ; divide by 10 to get rid of one more digit                
        mov dh, 0    ; i only want to push the remainder onto the stack, so i nullify the rest
        mov dl, ah   ; and place in the low part the remainder which was placed in ah
        push dx      ; push the remainder (current digit) onto the stack
        mov ah, 0    ; nullify the high part of ax;
        inc cx       ; count the current digit
        cmp al, 0    ; if i still can divide by 10 (the quotient is not yet 0)
        jne display_number ; then i keep looping
    
    display_stack:   
        pop dx       ; pop current digit from stack
        add dl, 48   ; add ascii code for '0'
        mov ah, 02h  ; OS code for displaying a character
        int 21h      ; interrupt
        dec cx       ; decrement cx
        cmp cx, 0    ; if there is anything more to display
        jne display_stack ; continue
        
        mov dl, 32   ; display a blank space
        mov ah, 02h
        int 21h                       
                                         
        pop cx       ; pop the number of numbers left to display from the stack
        cmp cx,0     ; if i have to display this number once more
        jne display_loop ; i display it once more
        jmp array_loop
        
        
   exit:     
   mov ax, 4C00h
   int 21h
end start
nt 21h
end start

revino_la_bucla_vector:

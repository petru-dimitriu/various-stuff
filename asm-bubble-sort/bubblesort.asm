.MODEL small
ORG 100h

.DATA                                                
array dw 5, 48, 3, 15, 4, 2, 2, 9, 10, 5

.CODE

jmp start
           
swap: ;swap cx and dx by pushing them and popping them in the same order                 
    push cx
    push dx
    pop cx
    pop dx            
    mov ax, 1 ; mark that we have done a swap
    jmp back_from_swap

check_end_i: ; check if we should stop inner loop
    pop bx     ; bx = current array pointer
    push ax    ; push ax to the stack so we dont lose its value
    lea ax, array ; load the address of the start of the array 
    add ax, 16 ; add (9 items - 1) * 2 bytes/item
    cmp bx,ax  ; if bx has NOT reached the penultimate item    
    pop ax
    jnz inner_loop ; keep passing through array 
    jmp outer_loop ; else it means we finished a pass through the array
           
start:                
    mov ax, 1           ; ax = 1 if we have to make another pass through the array, 0 otherwise
    outer_loop:         ; the loop which fires passes through the array
        cmp ax, 0       ; if ax = 0,
        jz the_end      ; then the array is sorted
        
        mov ax, 0       ; else we assume that it is sorted; if there's a swap during this pass we assume that it isnt
        lea bx, array   ; load address of start of array         
        inner_loop:     ; loop through the array
            mov cx, [bx]  ; move the current item to cx
            mov dx, [bx+2]; move the next item to dx
            cmp cx,dx     ; compare them   
            jg swap       ; if the are in wrong order, swap cx and dx
            back_from_swap:
            mov [bx], cx  ; move the new values back into the array
            mov [bx+2], dx
            add bx, 2     ; move the bx pointer 2 bytes forward to the next item                                 
            push bx       ; push bx because check_end_i expects to find bx on the stack so as to work with it
            jmp check_end_i
                
the_end:
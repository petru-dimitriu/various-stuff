; compute 1+..+n and fact(n)

.MODEL small
ORG 100h

.DATA
n dw 4 
sum dw 0
fact dw 0

.CODE

jmp start

start:
    lea bx, n
    mov cx, [bx]
    mov dx, 0
    mov ax, 0
    
    sum_loop:
    add ax, dx
    inc dx
    cmp dx, cx
    jnz sum_loop
    
    lea bx, sum
    mov [bx], ax         
    
    mov ax, 1
    mov bx, 1
    mul_loop:
    mul bl   
    inc bl
    cmp bl, cl
    jle mul_loop
    
    lea bx, fact
    mov [bx], ax
    
        
the_end:
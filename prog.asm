.MODEL small
.STACK 100h
.DATA

newString db 255, 0, 255 dup(?)
message1 db 'Enter a symbol string:', '$'
message2 db 'Same string but spaces are changed with previous symbols: ', '$'

.CODE       
start:  
    mov ax, @data		;saving data segment starting adress to ax register
	mov ds, ax
	
	mov dx, OFFSET message1
	mov ah, 9
	int 21h
	
	mov dl, 10
	mov ah, 2
	int 21h
	
	mov dx, OFFSET newString
	mov ah, 0Ah
	int 21h
	 
	mov dl, 10
	mov ah, 2
	int 21h
	
	mov al, newString[1]
	lea bx, newString + 2 
	doLoop:    
	    add al, 0 
	    jz stop
	    
	    cmp byte ptr[bx], 32
	    jz changeSpace
	    inc bx      
	    dec al
	    jmp doLoop
	 
	    changeSpace:
	    mov dl, [bx-1] 
	    mov [bx], dl
	    inc bx      
	    dec al               
    jmp doLoop
	     
	stop: 
	mov dx, OFFSET message2
	mov ah, 9
	int 21h
	
	mov dl, 10
	mov ah, 2
	int 21h

	mov bx, 0    
	mov bl, newString[1]
    mov newString[bx + 2],'$'
    mov dx, OFFSET newString + 2
    mov ah, 9
    int 21h
    
    mov ax, 4C00h					
	int 21h	  
	
end start
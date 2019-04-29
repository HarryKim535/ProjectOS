[org 0]
[bits 16]

jmp 0x07c0:start

start:
	mov ax, cs
	mov ds, ax
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	mov si, 0
paint:
	mov cl, byte [si+msg]
	mov ch, 0x0f
	mov word [es:di], cx
	inc si
	add di, 2
	cmp cl, 0
	jne paint

	mov ax, 0
	mov dl, 0
	int 0x13
	
	mov si, 0x1000
	mov es, si
	mov bx, 0
	mov di, word [tsec]
load:
	cmp di, 0
	je loadend
	sub di, 1
	
	mov ah, 2
	mov al, 1
	mov ch, byte [ntrack]
	mov cl, byte [nsec]
	mov dh, byte [nhead]
	mov dl, 0
	int 0x13
	
	add si, 0x20
	mov es, si
	mov al, byte [nsec]
	add al, 1
	mov byte [nsec], al
	cmp al, 19
	jl load
	
	xor byte [nhead], 1
	mov byte [nsec], 1
	cmp byte [nhead], 0
	jne load
	
	add byte [ntrack], 1
	jmp load
loadend:
	jmp 0x1000:0
	jmp $

msg: db "Booting...", 0
errmsg: db "Disk Error", 0
tsec: dw 1024
nsec: db 2
nhead: db 0
ntrack: db 0

times 510-($-$$) db 0

dw 0xaa55
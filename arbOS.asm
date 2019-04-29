[org 0]
[bits 16]

jmp 0x1000:start

sec: dw 0
tsec: equ 1024
start:
	mov ax, cs
	mov ds, ax
	mov ax, 0xb800
	mov es, ax
	
	%assign i 0
	%rep tsec
		%assign i i+1
		mov ax,2
		mul word [sec]
		mov si, ax
		mov byte [es:si + (160*2)], "0"+(i % 10)
		add word [sec], 1
		
		%if i == tsec
			jmp $
		%else 
			jmp (0x1000+i*0x20):0
		%endif
		times (512-($-$$) % 512) db 0
	%endrep
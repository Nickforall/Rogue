global _main
extern _printf

section .text

_main:
    push rbp
    mov rbp, rsp
    
    push "1"
    push "7"
    push "4"    

    ; realign stack
    sub rsp, 16
    
    mov rax, 0
    mov rcx, 0

    .start:
    add rcx, 1
    
    

    ; if the accumalator (rcx) < 4, jmp to start to loop again
    cmp rcx, 4
    jb .start
    
    ; exit(0)
    mov rdi, 0
    call exit

exit:
    mov rax, 0x2000001 ; exit syscall
    ; rdi is already set to the first argument (exit code)
    syscall

section .data
    input:      db "1023", 0
    inputlen:   db 4


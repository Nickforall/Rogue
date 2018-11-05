global _main
extern _printf

section .text

_main:
    push rbp
    mov rbp, rsp
    
    push 0 ; rbp 
    push 6 ; rbp + 8
    
    ; "47171"
    push "1"
    push "7" 
    push "1"
    push "7"
    push "4"    

    mov rbx, 0 ; tmp

    .start:
    ; decrease loop count from storage, if 0 jump to end
    mov rcx, [rbp-16]
    dec rcx
    jz .end 

    ; move the loop count back to storage
    mov [rbp-16], rcx 
    
    ; 10^(i-1) multiplier
    mov rdi, rcx
    dec rdi    
    call pow
    
    ; 0x30 = "0", so every ascii character after that is increasing by 1 
    pop rbx
    sub rbx, 0x30
    
    ; multiply the position's power by the number
    imul rax, rbx
    
    ; add the multiplier to storage
    mov rdx, [rbp-8]
    add rdx, rax
    
    ; move rdx back to the storage
    mov [rbp-8], rdx
    
    jmp  .start
    .end:
   
    ; exit(0)
    mov rdi, [rbp-8]
    call exit

; gets the power of 10 for a given amount of times
; rdi is power amount  
pow:
    push rbp
    mov rbp, rsp
  
    mov rax, 1 ; acc
    
    ; if rdi is zero, return 1 and skip power stuff
    cmp rdi, 0
    je .end

    ; if rdi isn't zero, we want to return a power of 10
    mov rax, 10    

    ; start loop   
    .start:
    dec rdi
    jz .end ; if rdi is zero, go to .end
    
    ; multiply rax by 10
    imul rax, 10
    
    ; loop back
    jmp .start
    .end:
    
    mov rsp, rbp
    pop rbp

    ret

exit:
    mov rax, 0x2000001 ; exit syscall
    ; rdi is already set to the first argument (exit code)
    syscall



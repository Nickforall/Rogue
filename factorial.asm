global _main
extern _printf

section .text

_main:
    push rbp
    mov rbp, rsp

    ; realign stack
    sub rsp, 16

    ; factorial(6)
    mov rdi, 10
    call factorial

    ; prints the result of factorial
    mov rdi, rax
    call print_digit

    mov rdi, 0
    call exit

print_digit:
    push rbp
    mov rbp, rsp

    ; align stack because fuck you steve
    sub rsp, 16

    mov rsi, rdi ; the digit that was passed to print_digit
    mov rdi, format ; "%d\n\0"
    
    call _printf

    ; move stack pointer back
    add rsp, 16

    mov rsp, rbp
    pop rbp

    ret

factorial:
    ; setup stack
    push rbp
    mov rbp, rsp

    push rdi ; push the first argument

    mov rax, [rbp-8]
    cmp rax, 1
    jb .return_one ; if n <= 1, stop and jump over recursion

    ; subtract 1, which will be the first arg of factorial
    mov rdi, [rbp-8]
    sub rdi, 1

    call factorial
    ; multiple the return value by our first arg
    imul rax, [rbp-8]

    ; jump to cleaning up stack n shit
    jmp .end_of_func

    .return_one:
    mov rax, 1

    .end_of_func:
    mov rsp, rbp
    pop rbp

    ret

exit:
    mov rax, 0x2000001 ; exit syscall
    ; rdi is already set to the first argument (exit code)
    syscall

section .data
            ; %d\n\0
    format: db "%d", 10, 0
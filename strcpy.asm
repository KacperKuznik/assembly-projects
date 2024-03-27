bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    format     db '%s', 0

section .bss
    input         resb 1024
    output         resb 1024

section .text
    main:
        sub     rsp, 8

        lea     rsi, [input + 0]
        lea     rdi, [format]
        mov     al, 0
        call    scanf wrt ..plt

        lea     rcx, [input + 0]
        lea     rdx, [output + 0]
        mov     rbx, 0
    loop:
        mov     al, byte [rcx+rbx]
        cmp     al, 0
        jz      print
        mov     byte [rdx+rbx], al
        add     rbx, 1
        jmp     loop
    print:
        mov     rsi, rdx
        lea     rdi, [format]
        mov     al, 0
        call    printf wrt ..plt
        
        add     rsp, 8
        sub     rax, rax
        ret
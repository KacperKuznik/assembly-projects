bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    input_format db '%d', 0
    format       db '%d', 32, 0
    
section .bss
    array       resd 100

section .text
    main:
        mov     rbx, 0
        mov     rcx, 0

    read:
        lea     rdi, [input_format]
        lea     rsi, [array + 0]
        mov     rax, 4
        mul     rcx
        add     rsi, rax

        push    rcx
        mov     al, 0
        call    scanf wrt ..plt

        pop rcx
        cmp     rax, 1
        jne     reading_ended
        
        add rcx, 1
        cmp rcx, 10
        jl read

    reading_ended:
        sub rsp, 8
    print:
        lea     rax, [array]
        add     rax, rbx
        mov     rsi, [rax]
        add     rbx, 4

        push    rcx
        mov     al, 0
        lea     rdi, [format]
        call    printf wrt ..plt
        pop     rcx

        sub     rcx, 1
        cmp     rcx, 0
        jg      print

    end:
        add     rsp, 8
        sub     rax, rax
        ret
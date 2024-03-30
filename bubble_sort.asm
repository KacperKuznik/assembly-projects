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
        sub     rsp, 8
        mov     r8, rcx
        mov     rdx, 0
    outer_loop:
        cmp     rdx, r8
        jg     print
        lea     rsi, [array]
        mov     rcx, 1
        add     rdx, 1
    inner_loop:
        mov eax, [rsi]
        mov ebx, [rsi+4]
        cmp eax, ebx
        jle no_swap
        mov dword [rsi+4], eax
        mov dword [rsi], ebx
    no_swap:
        mov     rbx, 0
        add     rsi, 4
        add     rcx, 1
        cmp     rcx, r8
        jl      inner_loop
        jmp     outer_loop
    print:
        mov     rcx, r8
    print_loop:
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
        jg      print_loop

    end:
        add     rsp, 8
        sub     rax, rax
        ret
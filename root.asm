bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    formatEndVal db '%f', 0

section .bss
    endValue    resq 1

section .text
    main:
        sub     rsp, 8
        mov     rcx, 0
        lea     rsi, [endValue + 0]
        lea     rdi, [formatEndVal]
        mov     al, 0
        call scanf wrt ..plt

    loop:
        cmp rcx, endValue
        jg end
        movq xmm0, rcx
        ; add rooting and printing the output
        add rcx, 1
    end:
        add     rsp, 8
        sub     rax, rax
        ret
bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    format_in_message   db 'Provide input in such structure: [k] [x] ', 0
    format_in           db '%d %lf', 0
    format_out          db 'e^x = %lf', 0xA, 0
    k                   dq 0
    x                   dq 0.0
    one                 dq 1.0
    align 16

section .bss

section .text

    main:
        sub     rsp, 8
        lea     rdi, [format_in_message]
        mov     al, 0
        call    printf wrt ..plt
        lea     rdi, [format_in]
        lea     rsi, [k]
        lea     rdx, [x]
        mov     al, 0
        call    scanf wrt ..plt

        mov       rbx, [k]      ;max iterator value
        mov       rcx, 1
        movlpd    xmm0, [one]   ;output
        movlpd    xmm1, [one]   ;iterator
        movlpd    xmm2, [one]   ;numerator
        movlpd    xmm3, [one]   ;denominator

    loop:
        cmp rcx, rbx
        jg end
        mulsd   xmm2, [x]
        mulsd   xmm3, xmm1
        movq    xmm4, xmm2
        divsd   xmm4, xmm3
        addsd   xmm0, xmm4
        addsd   xmm1, [one]
        add     rcx, 1
        jmp loop
    end:
        lea     rdi, [format_out]
        mov     al, 1
        call    printf wrt ..plt
        
        add     rsp, 8
        sub     rax, rax
        ret
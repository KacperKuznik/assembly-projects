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
    numerator           dq 1.0
    denominator         dq 1.0
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

        mov       rbx, [k]         ;max iterator value
        mov       rcx, 1
        movlpd    xmm0, [one]        ;output
        movlpd    xmm1, [one]          ;iterator

    loop:
        cmp     rcx, rbx
        je one_left
        cmp     rcx, rbx
        jg end

        ;calculating numerators for e^x and e^(x+1)
        movlpd  xmm7, [x]      ;temp x value
        mulsd   xmm7, [x]      ;temp x*x value
        movlhps xmm7, xmm7
        movlpd  xmm7, [x]
        movlpd  xmm2, [numerator]
        movhpd  xmm2, [numerator]
        mulpd   xmm2, xmm7     ;xmm2 has e^x and e^(x+1) numerators
        movhlps xmm7, xmm2
        movq    [numerator], xmm7

        ;calculating denominators
        movq  xmm4, xmm1
        movq  xmm7, xmm4
        addsd   xmm1, [one]
        mulsd   xmm7, xmm1
        movlhps xmm4, xmm7
        movlpd  xmm3, [denominator]
        movhpd  xmm3, [denominator]
        mulpd   xmm3, xmm4      ;xmm3 has e^x and e^(x+1) denominators
        movhlps xmm7, xmm3
        movq    [denominator], xmm7

        ;division
        divpd   xmm2, xmm3

        ;add to the output
        movq  xmm7, xmm2
        addsd   xmm0, xmm7
        movhlps xmm7, xmm2
        addsd   xmm0, xmm7
        
        addsd   xmm1, [one]
        add     rcx, 2
        jmp loop
    one_left:
        movlpd  xmm2, [numerator]
        movhpd  xmm2, [denominator]
        movlpd  xmm3, [x]
        movlhps  xmm3, xmm1
        mulpd   xmm2, xmm3
        movhlps xmm4, xmm2
        divsd   xmm2, xmm4
        addsd   xmm0, xmm2   
        jmp end
    end:
        lea     rdi, [format_out]
        mov     al, 1
        call    printf wrt ..plt
        
        add     rsp, 8
        sub     rax, rax
        ret
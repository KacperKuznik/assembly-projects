bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    format_in db '%lf', 0
    format_out db '%lf ', 0xA, 0
    start_value dq 0.0
    step dq 0.125

section .bss
    end_value    resq 1

section .text
    main:
        sub     rsp, 8
        lea     rsi, [end_value]
        lea     rdi, [format_in]
        mov     al, 0
        call    scanf wrt ..plt
        movsd  xmm4, xmm0 ;end conditon
        movlpd  xmm1, [start_value] ;iterator value

    loop:
        ; floating point comparison
        movsd xmm0, xmm4
        cmpltsd xmm0, xmm1
        movq    rax, xmm0
        cmp     rax, 2
        je      end
        sqrtsd  xmm0, xmm1

        lea     rdi, [format_out]
        mov     al, 1
        call    printf wrt ..plt
        ; adding 0.125 to the xmm1
        addsd   xmm1, 0.125
        jmp     loop

    end:
        add     rsp, 8
        sub     rax, rax
        ret
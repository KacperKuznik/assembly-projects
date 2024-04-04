bits    64
default rel

global  main

extern  printf
extern  scanf

section .data
    format_in db '%lf', 0
    format_out db 'sqrt(%lf) = %lf ', 0xA, 0
    
    align 16
    step   dq 0.125
    cur_step dq 0.0
    end_val     dq 5.2
section .bss

section .text
    main:
        sub     rsp, 8
        lea     rsi, [end_val]
        lea     rdi, [format_in]
        mov     al, 0
        call    scanf wrt ..plt

    square:
        movlpd     xmm0, [cur_step]
        movlpd     xmm2, [end_val]
        movq       xmm4, xmm0
        cmpltsd xmm4, xmm2
        movq    rax, xmm4
        cmp     rax, 0
        jz end

        sqrtsd  xmm1, xmm0
        lea     rdi, [format_out]
        mov     al, 1
        call    printf wrt ..plt
        movlpd    xmm0, [cur_step]
        addpd    xmm0, [step]
        movq    [cur_step] , xmm0
        
        jmp square

    end:
        add     rsp, 8
        sub     rax, rax
        ret
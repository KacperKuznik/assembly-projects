bits    64
default rel

global  main

extern  printf

section .data
    format      db 'Hello world!', 0xA, 0

section .bss
    output      resb 1

section .text
    main:
        sub     rsp, 8

        lea     rdi, [format]
        mov     al, 0
        call    printf wrt ..plt

        add     rsp, 8
        sub     rax, rax
        ret
.global creative
creative:
    MOV R7, #0
    MOV R8, #3
    MUL R6, R2, R3
    MUL R6, R8, R6
    ADD R6, R0

main:
    VLDMIA R0!,{D0-D3}
    VSTMIA R1!,{D2-D3}
    CMP R0, R6
    BGE return
    BAL main

return:
    MOV PC,LR

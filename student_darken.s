#Write your image darkening code here in assembly
.global sdarken
sdarken:
	mov r7, #0
	mov r8, #3
	mul r6, r2, r3
	mul r6, r8, r6
	add r6, r0
main:
	vldmia r0!,{d0-d3}
	vshr.u8 q0,q0,#1
	vshr.u8 q1,q1,#1
	vstmia r1!,{d0-d3}
	cmp r0, r6
	bge return
	bal main
return:
	MOV PC,LR


.global sepia
sepia:
	PUSH {LR}
	PUSH {R4-R12} 	
    MUL R4, R2, R3		//i < width*height
	MOV R5, #0			//Red pixel
	MUL R6, R2, R3		//Green stride
	ADD R7, R6, R6		//Blue stride

main:
	LDRB R8, [R0, R5]	//Loads red pixel value
	LDRB R9, [R0, R6]	//Loads green pixel value
	LDRB R10, [R0, R7]	//Loads blue pixel value

	MOV R12, #101
	MUL R8, R12
	LSR R8, #8
	MOV R12, #197
	MUL R9, R12
	LSR R9, #8
	ADD R8, R8, R9
	MOV R12, #48
	MUL R10, R12
	LSR R10, #8
	ADD R12, R10, R8
	
	LDRB R8, [R0, R5]	//Loads red pixel value
	LDRB R9, [R0, R6]	//Loads green pixel value
	LDRB R10, [R0, R7]	//Loads blue pixel value

	MOV R11, #89
	MUL R8, R11
	LSR R8, #8
	MOV R11, #176
	MUL R9, R11
	LSR R9, #8
	ADD R9, R9, R8
	MOV R11, #43
	MUL R10, R11
	LSR R10, #8
	ADD R11, R9, R10
	
	MOV R9, #255
	CMP R11, R9
	MOVGE R11, R9

	MOV R9, #255
	CMP R12, R9
	MOVGE R12, R9
	
	LDRB R8, [R0, R5]	//Loads red pixel value
	LDRB R9, [R0, R6]	//Loads green pixel value
	LDRB R10, [R0, R7]	//Loads blue pixel value

	STRB R12, [R1, R5]	//Stores new red pixel value
	STRB R11, [R1, R6]	//Stores new green pixel value

	MOV R12, #70
	MUL R8, R12
	LSR R8, #8
	MOV R12, #137
	MUL R9, R12
	LSR R9, #8
	ADD R8, R8, R9
	MOV R12, #34
	MUL R10, R12
	LSR R10, #8
	ADD R8, R10, R8

	MOV R9, #255
	CMP R8, R9
	MOVGE R8, R9

	STRB R8, [R1, R7]	//Stores new blue pixel value

	ADD R5, #1			//Incrementing red pixel iterator
	ADD R6, #1			//Adding incrementing location for green pixel to align with red
	ADD R7, #1			//Same deal as above but blue
	
	SUBS R4, #1			//For loop
    BLE return			//For loop
    BAL main			//For loop

return:
	POP {R4-R12}
	POP {PC} 
/*
#define R(i,j) (j*width+i)
#define G(i,j) (stride+j*width+i)
#define B(i,j) (stride+stride+j*width+i)
	
	void sepia(unsigned char *in,unsigned char *out, int width, int height) {
	    const int stride = width*height;
	    for (int i = 0; i < width; i++) {
	        for (int j = 0; j < height; j++) {
	            //Widen (8-bit x 8-bit = 16-bit)
	            unsigned short r = in[R(i,j)]*0.393 + in[G(i,j)]*0.769 + in[B(i,j)]*0.189;
	            unsigned short g = in[R(i,j)]*0.349 + in[G(i,j)]*0.686 + in[B(i,j)]*0.168;
	            unsigned short b = in[R(i,j)]*0.272 + in[G(i,j)]*0.534 + in[B(i,j)]*0.131;
	            //Saturate (clamp to 255)
	            if (r > 255) r = 255;
	            if (g > 255) g = 255;
	            if (b > 255) b = 255;
	            //Narrow (16-bit to 8-bit)
	            out[R(i,j)] = r;
	            out[G(i,j)] = g;
	            out[B(i,j)] = b;
	        }
	    }
	}
*/

//TODO: IDEAS
/*

	Multiple Loads:
	Load the three bytes over and over
	after every sepia operation per pixel.
	Basically: 
		[Load 3 pixels]
		
		Sepia math for RED pixel
		Store the finished result somewhere
		
		[Load 3 pixels]
		Sepia math for GREEN pixel
		etc...

*/

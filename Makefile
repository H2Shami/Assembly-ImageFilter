a.out: main.o student_creative.o
	g++ -mfpu=neon main.o student_creative.o

student_darken.o: student_darken.s
	as -mfpu=neon -o student_darken.o student_darken.s

student_sepia.o: student_sepia.s
	as -mfpu=neon -o student_sepia.o student_sepia.s

student_creative.o: student_creative.s
	as -mfpu=neon -o student_creative.o student_creative.s

main.o: main.cc
	#g++ -c -Dcimg_display=0 -fexceptions main.cc
	#g++ -O1 -c -Dcimg_display=0 -fexceptions main.cc
	#g++ -O3 -c -Dcimg_display=0 -fexceptions main.cc
	g++ -O3 -mfpu=neon -c -Dcimg_display=0 -Dstudent_creative -fexceptions main.cc

clean:
	rm -rf *.o a.out output.*

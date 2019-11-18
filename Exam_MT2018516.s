     AREA    circle, CODE, READONLY
	 IMPORT printMsg             
	 export __main	
	 ENTRY 
__main  function	
		VLDR.F32 S24,=0 ; angle initialization
		VLDR.F32 S16,=360; angle taken upto
	 	VLDR.F32 S15,=10; theta increment		
start   MOV R8, #35 ; value of radius
		MOV R0, #100 ; x shifted to
		MOV R1, #140 ; y shiifted to
		VMOV.F32 S19,R0; 
        VCVT.F32.U32 S19,S19; 
		VMOV.F32 S20,R1; converting y to fp
        VCVT.F32.U32 S20,S20; 
		VMOV.F32 S12,R8; converting radius to fp
        VCVT.F32.U32 S12,S12; 
		VMOV.F32 S17,S24
		BL sub1; subroutine
		VMUL.F32 S13,S12,S9; x = r*cos 
		VMUL.F32 S14,S12,S0; y = r*sin
		VADD.F32 S21,S13,S19; 
		VADD.F32 S22,S14,S20 ; 
		VCVT.S32.F32 S21,S21
		VCVT.S32.F32 S22,S22
		VCVT.U32.F32 S17,S17
		VMOV.F32 R0,S17
		VMOV.F32 R1,S21
		VMOV.F32 R2,S22
        BL printMsg	 ; Refer to ARM Procedure calling standards.
		VCMP.F32 S24, S16
		vmrs APSR_nzcv, FPSCR
		BEQ stop
		VADD.F32 S24, S15, S24
		B start
stop    B stop;  goto stop

sub1    MOV R0,#10 ; n
        MOV R1,#1; i
        VLDR.F32 S0,=1;sum of sine
        VLDR.F32 S1,=1;Temp sum of sine ,t
	 	VLDR.F32 S7,=57; degress into radians 
		VDIV.F32 S2,S17,S7 ;  degress into radians 
		VMOV.F32 S1,S2; t=x 
		VMOV.F32 S0,S2; sum=x 
		VLDR.F32 S8,=1; t=1 
		VLDR.F32 S9,=1; 
		
theta   CMP R1,R0;Compare 'i' and 'n'
        BLE angle;if i < n goto LOOP  
		BX lr ; else return from subroutine	


angle  	VMOV.F32 S3,R1; converting i to fp
        VCVT.F32.U32 S3,S3; Converting the value present in R1(i) into unsigned fp Number 32 bit
		VNMUL.F32 S4,S2,S2; -1*x*x
		MOV R9,#2
		MUL R2,R1,R9; 2i
		ADD R3,R2,#1; 2i+1
		SUB R6,R2,#1; 2i-1 
		MUL R3,R2,R3; 2i*(2i+1)  
		MUL R7,R2,R6; 2i*(2i-1) 
        VMOV.F32 S5,R3; 2i*(2i+1)
		VMOV.F32 S10,R7; 2i*(2i-1)
        VCVT.F32.U32 S5,S5; (2i*(2i+1))
		VCVT.F32.U32 S10,S10;(2i*(2i-1))
		VDIV.F32 S6,S4,S5 ; -(x*x)/2i*(2i+1)
		VDIV.F32 S11,S4,S10 ; -(x*x)/2i*(2i-1)
 		VMUL.F32 S1,S1,S6; t=t*(-1)*(x*x)/2i*(2i+1)
		VMUL.F32 S8,S8,S11; t=t*(-1)*(x*x)/2i*(2i-1)
		VADD.F32 S0,S0,S1;Sine series 
		VADD.F32 S9,S9,S8;Cosine series
		ADD R1,R1,#1; increment the value of i by 1
		B theta;;Again goto comparision
		
		endfunc
        end
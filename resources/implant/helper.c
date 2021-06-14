#include "helper.h"


// what to run when we start the program
void init_knocking(){
	knock_states = malloc(NUM_STATES * sizeof(int));
	for(int i=0; i<NUM_STATES; i++){
		knock_states[i]=0;
	}
}

// function to update the port knocking state
//	increments knock_state when dst port matches next 
void update_knock_state(int dst_port){

	// check if we can move onto the next part of the knock sequence
	if(KNOCK_1[knock_states[0]]==dst_port){
		knock_states[0]+=1;

		#ifdef DEBUG
			printf("Knocked on port %d, #%d in knock sequence 1\n", dst_port, knock_states[0]);
		#endif

		// check if this is end of the knock
		if(KNOCK_1[knock_states[0]] == 0){
			knocked_1();
			knock_states[0]=0;
		}
	}

	// 2nd knock sequence
	if(KNOCK_2[knock_states[1]]==dst_port){
		knock_states[1]+=1;

		#ifdef DEBUG
			printf("Knocked on port %d, #%d in knock sequence 2\n", dst_port, knock_states[1]);
		#endif

		// check if this is end of the knock
		if(KNOCK_2[knock_states[1]] == 0){
			knocked_2();
			knock_states[1]=0;
		}
	}

	// 3rd knock sequence
	if(KNOCK_3[knock_states[2]]==dst_port){
		knock_states[2]+=1;

		#ifdef DEBUG
			printf("Knocked on port %d, #%d in knock sequence 3\n", dst_port, knock_states[2]);
		#endif

		// check if this is end of the knock
		if(KNOCK_3[knock_states[2]] == 0){
			knocked_3();
			knock_states[2]=0;
		}
	}
}


// function to run when the 1st port knock occurs
void knocked_1(){
	printf("BANG 1\n");
}

// function to run when the 2nd port knock occurs
void knocked_2(){
	printf("BANG 2\n");
}

// function to run when the 3rd port knock occurs
void knocked_3(){
	printf("BANG 3\n");
}
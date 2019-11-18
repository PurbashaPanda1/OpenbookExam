#include "stm32f4xx.h"
#include <string.h>
void printMsg(const int a, const int b, const int c)
{
	 char Msg[100];
	 char *ptr;
	 sprintf(Msg, "Angle is %d degrees, ", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 sprintf(Msg, " x = %d, ", b);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 	 sprintf(Msg, " y = %d\n", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
	 } 
		 
}
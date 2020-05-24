int main(void)
{
	/*	----------------------------------------------------
						!!! ---- Define REGISTER MAP here --- !!!				*/
	
	volatile int *LEDs			= (int*) 0xFF200000;
	volatile int *HEX3_HEX0 = (int*) 0xFF200020;
	volatile int *SW_Switch = (int*) 0xFF200020;
	
	int hex_conversions [16] = {0x3F,
															0x40,
															0x41,
															0x42,
															0x43,
															0x44,
															0x45,
															0x46,
															0x47,
															0x48,
															0x49,
															0x4a,
	
	/*				!!! --- End of REGISTER MAP --- !!!
			----------------------------------------------------	*/
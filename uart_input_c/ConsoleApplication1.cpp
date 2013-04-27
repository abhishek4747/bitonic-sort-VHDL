#include "stdafx.h"
#include <windows.h>
#include <tchar.h>
#include <stdio.h>

void PrintCommState(DCB dcb)
{
    //  Print some of the DCB structure values
    _tprintf( TEXT("\nBaudRate = %d, ByteSize = %d, Parity = %d, StopBits = %d\n"), 
              dcb.BaudRate, 
              dcb.ByteSize, 
              dcb.Parity,
              dcb.StopBits );
}

int _tmain( int argc, TCHAR *argv[] ){
   DCB dcb;
   HANDLE hCom;
   BOOL fSuccess;
   TCHAR *pcCommPort = TEXT("\\\\.\\COM18");//  Most systems have a COM1 port
	//!!!!!!!!!! COM ports>9 need to be named as "\\\\.\\COMx" !!!!!!!!!!!!!!!

   //  Open a handle to the specified com port.
   hCom = CreateFile( pcCommPort,
                      GENERIC_READ | GENERIC_WRITE,
                      0,      //  must be opened with exclusive-access
                      NULL,   //  default security attributes
                      OPEN_EXISTING, //  must use OPEN_EXISTING
                      0,      //  not overlapped I/O
                      NULL ); //  hTemplate must be NULL for comm devices

   if (hCom == INVALID_HANDLE_VALUE) {
       //  Handle the error.
       printf ("CreateFile failed with error %d.\n", GetLastError());
	   getchar();
       return (1);
   }

   //  Initialize the DCB structure.
   SecureZeroMemory(&dcb, sizeof(DCB));
   dcb.DCBlength = sizeof(DCB);

   //  Build on the current configuration by first retrieving all current
   //  settings.
   fSuccess = GetCommState(hCom, &dcb);

   if (!fSuccess){
      //  Handle the error.
      printf ("GetCommState failed with error %d.\n", GetLastError());
	  getchar();
      return (2);
   }

   PrintCommState(dcb);       //  Output to console

   //  Fill in some DCB values and set the com state: 
   //  57,600 bps, 8 data bits, no parity, and 1 stop bit.
   dcb.BaudRate = CBR_38400;     //  baud rate
   dcb.ByteSize = 8;             //  data size, xmit and rcv
   dcb.Parity   = NOPARITY;      //  parity bit
   dcb.StopBits = ONESTOPBIT;    //  stop bit

   fSuccess = SetCommState(hCom, &dcb);

   if (!fSuccess){
      //  Handle the error.
      printf ("SetCommState failed with error %d.\n", GetLastError());
      getchar();
	  return (3);
   }

   //  Get the comm config again.
   fSuccess = GetCommState(hCom, &dcb);

   if (!fSuccess){
      //  Handle the error.
      printf ("GetCommState failed with error %d.\n", GetLastError());
      getchar();
	  return (2);
   }

   PrintCommState(dcb);       //  Output to console

   _tprintf (TEXT("Serial port %s successfully reconfigured.\n\nReset FPGA Board and Press Enter to Continue..."), pcCommPort);
	
   getchar();
   
	char output[64], input[64];
	DWORD dwBytesRead = 0;
	DWORD dwBytesWritten=0;

	int arr[16] = {0,1,45435352,3,128,43,6,775675756,-8,9,0,-4241,2,3,4,5};
	printf("\nInput: ");
	for(int i = 0; i < 16; ++i)	{
		input[4*i+0] = (arr[i]>>24)&255;
		//printf("%d ", input[4*i+0]);
		input[4*i+1] = (arr[i]>>16)&255;
		//printf("%d ", input[4*i+1]);
		input[4*i+2] = (arr[i]>>8)&255;
		//printf("%d ", input[4*i+2]);
		input[4*i+3] = (arr[i])&255;
		//printf("%d ", input[4*i+3]);
		printf("%d ", arr[i]);
	}

	
	if(!WriteFile(hCom,input,sizeof(input),&dwBytesWritten,NULL)){
		printf ("WriteFile failed with error %d.\n", GetLastError());
		getchar();
		return (2);
	}
	
	printf("\nOutput: ");
	if(!ReadFile(hCom, output, sizeof(output), &dwBytesRead, NULL)){
		printf ("ReadFile failed with error %d.\n", GetLastError());
		getchar();
		return (2);
	} 
	for(int x=0;x<16;x++)	{
		int t = 0;
		t |= output[4*x+0]<<24;
		//printf("%d ", output[4*x+0]);
		t |= (((int)output[4*x+1])&255)<<16;
		//printf("%d ", output[4*x+1]);
		t |= (((int)output[4*x+2])&255)<<8;
		//printf("%d ", output[4*x+2]);
		t |= (((int)output[4*x+3])&255);
		//printf("%d ", output[4*x+3]);
		printf("%d ", t);
	}
	
	printf("\n\nPress Enter to exit...");
	CloseHandle(hCom);
	getchar();
	return (0);
}


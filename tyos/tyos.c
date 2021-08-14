/* <file> - <One-line note about this file>
 
   Copyright (c) <YEAR>, <AUTHOR> 

   This piece of software is a derivative work of SYSeg, by Monaco F. J.
   SYSeg is distributed under the license GNU GPL v3, and is available
   at the official repository https://www.gitlab.com/monaco/syseg.

   This file is part of <PROJECT>.

   <PROJECT> is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/



#include <tyos.h>
#include <extra.h>



void halt()
{

  printnl ("Bye!");
  __asm__ volatile
    (
     "loop%=:           ;"
     "        hlt       ;"
     "        jmp loop%=;"
     :::
     );
}

////////////////////////Funções do mbr

/* Read string from terminal into buffer. 

   Note: this function does not check for buffer overrun.
         Buffer size is BUFFER_MAX_LENGTH.

	 Good opportunity for contributing.

*/

void __attribute__((fastcall, naked)) read (char *buffer)
{
  
    __asm__ volatile
    (     
     
     "   mov $0x0, %%si               ;" /* Iteration index for (%bx, %si).  */
     "loop%=:                         ;"
     "   movw $0X0, %%ax              ;" /* Choose blocking read operation.  */
     "   int $0x16                    ;" /* Call BIOS keyboard read service. */
     "   movb %%al, %%es:(%%bx, %%si) ;" /* Fill in buffer pointed by %bx.   */
     "   inc %%si                     ;"
     "   cmp $0xd, %%al               ;" /* Reiterate if not ascii 13 (CR)   */

     "   mov   $0x0e, %%ah            ;" /* Echo character on the terminal.  */
     "   int $0x10                    ;"
     
     "   jne loop%=                   ;"

     " mov $0x0e, %%ah                ;" /* Echo a newline.                  */
     " mov $0x0a, %%al                ;"
     "   int $0x10                    ;"
     
     "   movb $0x0, -1(%%bx, %%si)    ;" /* Add buffer a string delimiter.   */
     "   ret                           " /* Return from function             */
     
     :
     : "b" (buffer) 	          /* Ask gcc to store buffer in %bx          */
     : "ax",  "cx", "si" 	  /* Aditional clobbered registers.          */
     );

  
}


/*  Output a help(-less) message. 

    -> Not Enough MBR Space :'(
*/

void __attribute__((naked)) help (void)
{
  printnl ("Help:");
  printnl ("time:");
  printnl ("quit:");


  __asm__ ("ret");   	   // Naked functions lack return.

}

/* Show the system Time by RTC BIOS interupt */

int __attribute__((fastcall, naked)) time (void)
{
  __asm__ volatile
    (
      " mov $0x04,  %%ah  ;"
      " int $0x1A         ;"
      " mov	$0x0e,  %%ah  ;"

      " mov %%dl,   %%al  ;"
      " shr $0x04,  %%al  ;"
      " add $0x30,  %%al  ;"
      
      " int $0x10          ;"

      " mov	%%dl,   %%al  ;"
      "	and	$0x0F,  %%al  ;" 
      "	add	$0x30,  %%al  ;"

      " int $0x10         ;"
      " mov	$0x2F,  %%al  ;"
      " int $0x10         ;"

      " mov %%dh,   %%al  ;"
      " shr $0x04,  %%al  ;"
      " add $0x30,  %%al  ;"
      
      " int $0x10          ;"

      " mov	%%dh,   %%al  ;"
      "	and	$0x0F,  %%al  ;" 
      "	add	$0x30,  %%al  ;"

      " int $0x10         ;"
      " mov	$0x2F,  %%al  ;"
      " int $0x10         ;"

      " mov %%cl,   %%al  ;"
      " shr $0x04,  %%al  ;"
      " add $0x30,  %%al  ;"
      
      " int $0x10          ;"

      " mov	%%cl,   %%al  ;"
      "	and	$0x0F,  %%al  ;" 
      "	add	$0x30,  %%al  ;"
//////////////////

      " int $0x10         ;"
      " mov	$0x20,  %%al  ;"
      " int $0x10         ;"
///////////////

      " mov $0x02,  %%ah  ;"
      " int $0x1A         ;"
      " mov	$0x0e,  %%ah  ;"

      " mov %%ch,   %%al  ;"
      " shr $0x04,  %%al  ;"
      " add $0x30,  %%al  ;"
      
      " int $0x10          ;"

      " mov	%%ch,   %%al  ;"
      "	and	$0x0F,  %%al  ;" 
      "	add	$0x30,  %%al  ;"

      " int $0x10         ;"
      " mov	$0x3A,  %%al  ;"
      " int $0x10         ;"

      " mov %%cl,   %%al  ;"
      " shr $0x04,  %%al  ;"
      " add $0x30,  %%al  ;"
      
      " int $0x10          ;"

      " mov	%%cl,   %%al  ;"
      "	and	$0x0F,  %%al  ;" 
      "	add	$0x30,  %%al  ;"

      " int $0x10          ;"
      " ret               ;"
      ::: "ax", "cx", "dx" 	    // Aditional clobbered registers.
     );
}

/* Compare two strings up to position BUFFER_MAX_LENGTH-1. */

int __attribute__((fastcall, naked)) compare (char *s1, char *s2)
{
  __asm__ volatile
    (
      "    mov %[len], %%cx   ;"
      "    mov $0x1, %%ax     ;"
      "    cld                ;"
      "    repe  cmpsb        ;"
      "    jecxz  equal       ;"             
      "    mov $0x0, %%ax     ;"
      "equal:                 ;"
      "    ret                ;"
      :
      : [len] "n" (BUFFER_MAX_LENGTH-1), /* [len] is a constant.   */
	"S" (s1),		/* Ask gcc to store s1 in %si      */
	"D" (s2)		/* Ask gcc to store s2 is %di      */
      : "ax", "cx", "dx"	/* Additional clobbered registers. */
     );

  return 0;                /* Bogus return to fulfill funtion's prototype.*/
}
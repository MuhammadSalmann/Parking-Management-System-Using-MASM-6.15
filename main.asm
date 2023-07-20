;                           =============================================================================
;                           =---------------- Computer Organization & Assembly Language ----------------=
;                           =============================================================================

;                           =============================================================================
;                           =------------------------------ TERM PROJECT -------------------------------=
;                           =----------------------- PARKING MANAGEMENT SYSTEM -------------------------=

;                           =------------------------------ Group Members ------------------------------=
;                           =----Salman Siddiqui----------- Qurat ul Ain ---------------Sulman Haider---=
;                           =--------210920--------------------210958--------------- -------210991------=
;                           =============================================================================

include mylib.lib
.model small
.stack 100h
.386
.data
;===============================================================
MAIN_MENU
EXIT_DISPLAY
UA_DISPLAY
;*****************USER MENU**********************************
USER_MENU
BIKE
CYCLE
CAR
BUS
Line
Line2
PARKED
;*****************ADMIN MENU**********************************
ADMIN_MENU
AllRecords
Updatee
Updateed
Create_Receipt
Delete_Alll
Createe
WRONG_INPUT
;******************DETAILS************************************
SomeMsg
inf_Name  db 10,10,'                  Name         :     $'
inf_Model db 10,10,'   Transport Name & Model      :     $'
inf_Time  db 10,10,' Duration of Parking(In Hours) :     $'
inf_Fee   db 10,10,'            TOTAL BILL :  Rs.  $'
sizeofmsg dw ?
;******************FILE**************************************
FileName db "Park.txt",0
Handle   dw ?
buffer   db 1000 dup('$')
NextLine db 10,'$'
;******************VARIABLE***********************************
Namee       db 20 dup(?)
sizeofModel dw 0
Modell      db 20 dup(?)
sizeofName  dw 0
Time        dw ?
temp        dw ?
Total       dd ?
Precision   dw 4
Address     dw ?
tempp       db 0
;================================================================
.code
Main proc
mov ax,@data						;to bring data from .code
mov ds,ax
;*****************MAIN SCREEN**********************************
 String M1							;Displaying Menu Using Macros in the Mylib library		
 Unique
 call Cls							;Procedure used to clear screen
 
 blueback							;For Graphics
 boldscreen1
 
 String M1
 InputR								;Taking input for stoping the screen to show menu
 call Cls
;*****************MAIN MENU**********************************
 back:
 
 blueback						;For Graphics
 DATE
 String U1						;Printing user admin menu
 InputR
 mov ch,al						;Taking choice of user and storing it in ch register
 call Cls

 .if ch == '1'
 jmp UserMenu
 .elseif ch == '2'
 jmp AdminMenu
 .else
 call Cls
 Blink
 String W1
 InputR
 jmp back
 .endif
 
;*****************USER MENU**********************************
 UserMenu:
 blueback				;Graphics
 boldscreen
 
 String U2				;Printing next menu			
 InputR
 mov ch,al				;Taking input and storing in ch
 call Cls
 
 .if ch == '1'
 call BikeFee
 call Cls
 jmp UserMenu
 
 .elseif ch == '2'
 call BusFee
 call Cls
 jmp UserMenu
 
 .elseif ch == '3'
 call CycleFee
 call Cls
 jmp UserMenu
 
 .elseif ch == '4'
 call CarFee
 call Cls
 jmp UserMenu
 
 .elseif ch == '5'
 jmp back
 
 .elseif ch == '6'
 jmp Exitt
 
 .else
 call Cls
 Blink
 String W1
 InputR
 jmp UserMenu
 .endif
 
;*****************ADMIN MENU**********************************
 AdminMenu:
 blueback			;Graphics
 boldscreen
 
 String A2			;Printing Admin menu
 InputR
 mov ch,al			;Taking input and storing in ch
 call Cls
 
 .if ch == '1'
 call DisplayAll
 call Cls
 jmp AdminMenu
 
 .elseif ch == '2'
 call Delete_All
 call Cls
 jmp AdminMenu
 
 .elseif ch == '3'
 call CreateF
 call Cls
 jmp AdminMenu
 
 .elseif ch == '4'
 call Update
 call Cls
 jmp AdminMenu
 
 .elseif ch == '5'
 call Search
 call Cls
 jmp AdminMenu
 
 .elseif ch == '6'
 jmp back
 
 .elseif ch == '7'
 jmp Exitt
 
 .else
 call Cls
 Blink
 String W1
 InputR
 jmp AdminMenu
 .endif
  
 Exitt:
 call Exit			; to exit the program
 
 Errorr:
 String W1
 call Exit
main endp

;************************ PROCEDURES *************************
;************************ FOR USER ***************************
BikeFee proc
 blueback			;graphics
 boldscreen3
 
 String B1
 call Information
 
 .if tempp >= 1
 mov tempp,0
 ret
 .endif
 
 mov bx,30
 call CalculateBill

 ;******Displaying*******
 String l1
 String inf_Fee
 call ShowBill
 
 String tempMsg
 String l2
 InputR
 call Cls
 
 blueback		;Graphics
 boldscreen2
 
 String tempMsg1
 InputR
 call Cls
 Beep
 Square
 String P1
 InputR
ret
BikeFee endp

BusFee proc
 blueback
 boldscreen3
 
 String B2
 call Information
 
 .if tempp >= 1
 mov tempp,0
 ret
 .endif
 
 mov bx,200
 call CalculateBill

 ;******Displaying*******
 String l1
 String inf_Fee
 call ShowBill
 String tempMsg
 String l2
 InputR
 call Cls
 blueback
 boldscreen2
 String tempMsg1
 InputR
 call Cls
 Beep
 Square
 String P1
 InputR
ret
BusFee endp

CycleFee proc
 blueback
 boldscreen3
 
 String C1
 call Information
 
 .if tempp >= 1
 mov tempp,0
 ret
 .endif
 
 mov bx,15
 call CalculateBill

 ;******Displaying*******
 String l1
 String inf_Fee
 call ShowBill
 String tempMsg
 String l2
 InputR
 call Cls
 blueback
 boldscreen2
 String tempMsg1
 InputR
 call Cls
 Beep
 Square
 String P1
 InputR
ret
CycleFee endp

CarFee proc
 blueback
 boldscreen3
 
 String C2
 call Information
 
 .if tempp >= 1
 mov tempp,0
 ret
 .endif
 
 mov bx,120
 call CalculateBill

 ;******Displaying*******
 String l1
 String inf_Fee
 call ShowBill
 String tempMsg
 String l2
 InputR
 call Cls
 blueback
 boldscreen2
 String tempMsg1
 InputR
 call Cls
 Beep
 Square
 String P1
 InputR
ret
CarFee endp

Information proc
 OpenFile FileName,Handle,1
 mov sizeofmsg,lengthof L3
 WriteFile L3,Handle,sizeofmsg
 
 String inf_Name
 mov sizeofmsg,lengthof NameMsg
 WriteFile NameMsg,Handle,sizeofmsg
 
 UserString Namee, sizeofName, strt, endd
 WriteFile Namee,Handle,sizeofName
 
 String inf_Model
 mov sizeofmsg,lengthof ModelMsg
 WriteFile ModelMsg,Handle,sizeofmsg
 
 UserString Modell, sizeofModel, strtt, enddd
 WriteFile Modell,Handle,sizeofModel
 
 String inf_Time
 mov sizeofmsg,lengthof TimeMsg
 WriteFile TimeMsg,Handle,sizeofmsg
 mov ah,1
 int 21h
 mov ah,0
 sub al,48
 mov Time,ax
 
 mov si,offset tempArray			;Temporary Array to store Time
 add ax,48
 mov [si],ax
 mov sizeofmsg,1
 WriteFile tempArray,Handle,sizeofmsg
 
 
ret
 Errorr:
 call Cls
 Blink
 String D1
 InputR
 inc tempp
ret
Information endp

CalculateBill proc
 pop ax
 mov address,ax
 
 mov ax,Time
 mul bx
 mov Total,eax			;storing in a temparary variable
 
 mov cx,Precision				;setting loop to possible output value after multiplication
 looop:
 mov temp,cx				;Storing looping value in a temparary variable
 mov eax,Total
 mov bx,10
 div bx					;Dividing the main value by 10
 mov cx,dx
 push cx					;pushing the remainder in stack so that when wo pop it we can get the answere in the correct meanng as it will be stored in reverse
 mov dx,0
 mov Total,eax			;Stroing the quotient in the main sum for repeating the process
 mov cx,temp				;restoring value of loop
 loop looop

 push address
ret
CalculateBill endp

ShowBill proc
 pop ax
 mov address,ax
 
 mov sizeofmsg,lengthof FeeMsg
 WriteFile FeeMsg,Handle,sizeofmsg
 mov si,offset tempArray			;Temporary Array to store Time
 
 mov cx,Precision				;setting loop to possible output value after multiplication
 display:
 pop dx							;poping the reaminders to get final values and displaying it
 add dx,48
 mov [si],dx
 inc si
 mov ah,2
 int 21h
 loop display
 
 mov dx,Precision
 mov sizeofmsg,dx
 WriteFile tempArray,Handle,sizeofmsg
 mov sizeofmsg,lengthof L3
 WriteFile L3,Handle,sizeofmsg
 CloseFile Handle
 
 push address
ret
 Errorr:
 call Cls
 Blink
 String D1
 InputR
 inc tempp
ret
ShowBill endp

;************************ PROCEDURES *************************
;************************ FOR ADMIN ***************************

DisplayAll proc
 blueback
 boldscreen3
 OpenFile FileName,Handle,0
 String A3
 ReadFile buffer,Handle			;Macro to Read File defined in mylib.lib file
 
 String buffer

 CloseFile Handle 
 InputR
ret
 Errorr:
 call Cls
 Blink
 String D1
 InputR
ret
DisplayAll endp

CreateF proc
 Blink
 String C3
 InputR
 CreateFile FileName,Handle			;Creating File int the Start
 CloseFile Handle
ret
 Errorr:
 String W1
 call Exit
CreateF endp

Delete_All proc
 DeleteFile FileName
 
 mov si,offset buffer			;Clearing the buffer for not displaying the previous record
 mov cx,lengthof buffer
 Clearr:
 mov bl,[si]
 cmp bl,'$'
 je break
 mov bh,[si]
 mov bh,'$'
 mov [si],bh
 inc si
 loop Clearr
 break:
 Blink
 String D2
 InputR
ret
 Errorr:
 String D1
ret
Delete_All endp

Update proc
 blueback
 mov si,offset buffer			;Clearing the buffer for not displaying the previous record
 mov cx,lengthof buffer
 Clearr:
 mov bl,[si]
 cmp bl,'$'
 je break
 mov bh,[si]
 mov bh,'$'
 mov [si],bh
 inc si
 loop Clearr
 break:
 
 String A4
 call Information
 String Updateprice
 mov ah,1
 int 21h
 mov ah,0
 sub al,48
 mov bx,ax
 call CalculateBill
 call ShowBill
 call Cls
 Blink
 String A5
 InputR
ret
Update endp

Search proc
 blueback
 mov sizeofsearch,0
 mov tempsize,0
  
 mov si,offset buffer
 mov bl,[si]
 .if bl == '$'
 jmp wrg
 .endif
 
 String searchmsg
 UserString SearchArray, sizeofsearch, strt, endd
 mov si,offset SearchArray
 mov di,offset Namee
 mov cx,sizeofsearch
 searching:
 mov dh,[si]
 mov bh,[di]
 
 cmp dh,bh
 je okk
 inc di
 bkk:
 loop searching
 
 mov bx,tempsize
 .if sizeofsearch == bx
 call DisplayAll
 InputR
 .else
 jmp wrg
 .endif
 
ret
 wrg:
 Blink
 String W1
 InputR
ret

 okk:
 inc si
 inc di
 inc tempsize
 jmp bkk
 
Search endp

OutputT proc		;Procedure to show Output

mov dl,bh		;Diplaying First Part of Hours
add dl,48
mov ah,02h
int 21h
mov dl,bl		;Diplaying Second Part of Hours
add dl,48
mov ah,02h
int 21h
ret
OutputT endp

;-----------------------------------------------------------------------------------
Endline proc	;Next Line
mov ah,02  
mov dl,10
int 21h
ret
Endline endp

Space proc
mov dl,' ' 
mov ah,2
int 21h
ret
Space endp

Colon proc		;procedure to print :
mov dl,':' 
mov ah,02h
int 21h
ret
Colon endp

Slash proc		;procedure to print /
mov dl,'/' 
mov ah,02h
int 21h
ret
Slash endp

Exit proc	;Exit
blueback
boldscreen
String E1
mov ah,4ch 
int 21h
ret
Exit endp

Cls proc    ;Clear Screen
mov ax,07h   
int 10h
ret
Cls endp
;---------------------------------GRAPHICS---------------------------------------
dly proc
push cx
mov cx,0h
loop $
pop cx
ret
dly endp

end main
list P=16F84A
#include <p16f84a.inc>

STATUS      equ     0x03
PORTA       equ     0x05
PORTB       equ     0x06
TRISA       equ     0x85
TRISB       equ     0x86
OPTION_REG  equ     0x81
RP0         equ     5

org 0x000

bsf STATUS, RP0     ; เลือก bank 1
movlw 0x10          ; ตั้งค่าให้ขา RA4 เป็น Input
movwf TRISA         ; โหลดค่า 0x10 เข้า TRISA (ตัวบอร์ดที่ต้องการให้เป็น Input)

movlw 0x01          ; ตั้งค่าให้ขา RB0 เป็น Input
movwf TRISB         ; โหลดค่า 0x01 เข้า TRISB (ตัวบอร์ดที่ต้องการให้เป็น Input)

bcf STATUS, RP0     ; เลือก bank 0

MAIN_LOOP:
    btfss PORTA, 4   ; ตรวจสอบว่าเจอเปลวไฟหรือไม่ (ขา RA4)
    goto FLAME_PRESSED ; ถ้าเจอ ไปที่ FLAME_PRESSED
    bsf PORTA, 0      ; ตั้งขา RA0 bank เป็น 0 Buzzer ไม่ดัง
    bcf PORTA, 2      ; ตั้งขา RA2 bank เป็น 0 LED สีแดงดับ 
    goto SECOND_LOOP   ; ไปลูป 2

SECOND_LOOP:
    btfss PORTB, 0  ; ตรวจสอบว่าพบแก๊สหรือไม่ (ขา RB0)
    goto SMOKE_PRESSED ; ถ้าเจอ ไปที่ SMOKE_PRESSED
    bcf PORTA, 1     ;ตั้งขา RA1 bank เป็น 0 Buzzer ไม่ดัง
    bsf PORTA, 3	 ; ตั้งขา RA2 bank เป็น 0 LED สีแดงดับ 
    goto MAIN_LOOP   ;ไปวนลูป

FLAME_PRESSED:   	 ;ตรวจเจอเปลวไฟ
    bcf PORTA, 0      ; ตั้งขา RA0 bank เป็น 1 Buzzer ดัง
    bsf PORTA, 2      ; ตั้งขา RA2 bank เป็น 1 LED สีแดงติด
    bsf PORTB, 1      ; ตั้งขา RB1 เป็น 1 (IN1)
    bcf PORTB, 2      ; ตั้งขา RB2 เป็น 0 (IN2)
    goto MAIN_LOOP    ; วนลูป

SMOKE_PRESSED:        ;ตรวจเจอแก๊ส
    bsf PORTA, 1      ; ตั้งขา RA1 bank เป็น 1 Buzzer ดัง
    bcf PORTA, 3      ; ตั้งขา RA3 bank เป็น 1 LED สีเหลือง
    bcf PORTB, 1      ; ตั้งขา RB1 เป็น 0 (IN1)
    bcf PORTB, 2      ; ตั้งขา RB2 เป็น 0 (IN2)
    goto MAIN_LOOP    ; วนลูป

end

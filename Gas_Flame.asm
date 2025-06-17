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

bsf STATUS, RP0     ; ���͡ bank 1
movlw 0x10          ; ��駤������ RA4 �� Input
movwf TRISA         ; ��Ŵ��� 0x10 ��� TRISA (��Ǻ��촷���ͧ�������� Input)

movlw 0x01          ; ��駤������ RB0 �� Input
movwf TRISB         ; ��Ŵ��� 0x01 ��� TRISB (��Ǻ��촷���ͧ�������� Input)

bcf STATUS, RP0     ; ���͡ bank 0

MAIN_LOOP:
    btfss PORTA, 4   ; ��Ǩ�ͺ���������������� (�� RA4)
    goto FLAME_PRESSED ; ����� 价�� FLAME_PRESSED
    bsf PORTA, 0      ; ��駢� RA0 bank �� 0 Buzzer ���ѧ
    bcf PORTA, 2      ; ��駢� RA2 bank �� 0 LED ��ᴧ�Ѻ 
    goto SECOND_LOOP   ; ��ٻ 2

SECOND_LOOP:
    btfss PORTB, 0  ; ��Ǩ�ͺ��Ҿ����������� (�� RB0)
    goto SMOKE_PRESSED ; ����� 价�� SMOKE_PRESSED
    bcf PORTA, 1     ;��駢� RA1 bank �� 0 Buzzer ���ѧ
    bsf PORTA, 3	 ; ��駢� RA2 bank �� 0 LED ��ᴧ�Ѻ 
    goto MAIN_LOOP   ;�ǹ�ٻ

FLAME_PRESSED:   	 ;��Ǩ������
    bcf PORTA, 0      ; ��駢� RA0 bank �� 1 Buzzer �ѧ
    bsf PORTA, 2      ; ��駢� RA2 bank �� 1 LED ��ᴧ�Դ
    bsf PORTB, 1      ; ��駢� RB1 �� 1 (IN1)
    bcf PORTB, 2      ; ��駢� RB2 �� 0 (IN2)
    goto MAIN_LOOP    ; ǹ�ٻ

SMOKE_PRESSED:        ;��Ǩ�����
    bsf PORTA, 1      ; ��駢� RA1 bank �� 1 Buzzer �ѧ
    bcf PORTA, 3      ; ��駢� RA3 bank �� 1 LED ������ͧ
    bcf PORTB, 1      ; ��駢� RB1 �� 0 (IN1)
    bcf PORTB, 2      ; ��駢� RB2 �� 0 (IN2)
    goto MAIN_LOOP    ; ǹ�ٻ

end

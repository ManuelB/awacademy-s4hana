*&---------------------------------------------------------------------*
*& Report Z_S11_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_schleifen.

DATA: lv_i     TYPE i VALUE 1,
      lv_times TYPE i VALUE 10,
      lv_datum TYPE date VALUE 1,
      lv_monat TYPE date VALUE 1,
lv_jahr type date value 2022.

DATA: date_1 TYPE D.

date_1 = SY-DATUM.
Write: / 'Present Date is:', date_1 DD/MM/YYYY.

DO lv_times TIMES.
  WRITE :/ lv_i.
  ADD 10 TO lv_i.
  IF lv_i GT 30.
    EXIT. "Abbruchbedingung
  ENDIF.

ENDDO.

ULINE.

WRITE :/ `while schleife`.

WHILE lv_times GE 0.
  SUBTRACT 1 FROM lv_times.

  DATA(lv_rest) = lv_times  MOD 2.
  IF lv_rest IS INITIAL.
    CONTINUE.
  ENDIF.
  WRITE :/ lv_times.

ENDWHILE.

ULINE.
WRITE :/ 'Übungsaufgabe : Tage desMonats Februar'.

WHILE lv_monat LE 2.
  WHILE lv_datum LE 2.
   WRITE :/ lv_datum,'-', lv_monat, '-', lv_jahr dd/MM/YY.
    write:/ |{ lv_datum }{ lv_monat }{ lv_jahr }|.
    ADD 1 TO lv_datum.
  ENDWHILE.
  lv_datum = 1.
  ADD 1 TO lv_monat.

ENDWHILE.

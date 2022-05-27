*&---------------------------------------------------------------------*
*& Report Z_S01_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_hostvar.

*verstanden

*Nur Frame.
SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*Erstellung der Parameter.
  PARAMETERS:
    p_FLDATE TYPE s_date,
    p_carr   TYPE s_carr_id,
    P_price TYPE s_price DEFAULT 500.


SELECTION-SCREEN END OF BLOCK a1.


*Start der SQL-Schleife.
*Hier wird Struktur definiert. *Hostvariable ist @Data (...) ist  Deklaration einer variable.

**Start of ... definiert den Standardverarbeitungsblock eines ausführbaren Programms
*START-OF-SELECTION.
**Wähle einzelne Zeile aus fldate, carrid, auf die Die Bedingung der eingaben in Parametern entspricht.
*  SELECT SINGLE fldate, carrid INTO @DATA(flights)
*    FROM sflight
*    WHERE fldate = @p_FLDATE
*    AND carrid = @p_carr.
*  WRITE: / flights.
**  Hier Bedingung um 0 zu vermeiden.
*  ENDSELECT.
**Bei mehrzeiligen Ergebnismenge einer select Schleife, muss ENDSELECT abgeschlossen werden

START-OF-SELECTION.

  SELECT SINGLE carrid, price INTO @DATA(result)
    FROM sflight
    WHERE price < @p_price.

cl_demo_output=>display( result ).

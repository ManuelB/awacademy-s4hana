*&---------------------------------------------------------------------*
*& Report Z_S01_SCHLEIFEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_schleifen.
*Verstanden.

* So kann man auch variablen deklarieren.
DATA: lv_i     TYPE i VALUE 1,
      lv_times TYPE i VALUE 5.
.

WRITE:/ 'DO Schleife'.
*Do Schleife
DO lv_times TIMES.

  WRITE: / lv_i.

  lv_i = lv_i + 10.

  IF lv_i > 30.
    EXIT. "Abbruchbedingung
  ENDIF.

ENDDO.

ULINE.

WRITE:/ 'WHILE Schleife'.
*WHILE Schleife

lv_times = 30.

WHILE lv_times > 0.

  lv_times = lv_times - 1.

  DATA(lv_rest) = lv_times MOD 2.
*Variante für DATA: lv_rest. lv_rest =  lv_times MOD 2.

  IF lv_rest IS INITIAL. "Is initial ist der InitialWert. WEnn nichtdefiniiert, dann Null, ansonsten wie man es definiert."
    CONTINUE. "Weiches Ende. Bricht nur die aktuelle SChleife ab.
  ENDIF.

  WRITE: / lv_times.



ENDWHILE.

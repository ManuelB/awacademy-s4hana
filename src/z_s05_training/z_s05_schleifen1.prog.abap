*&---------------------------------------------------------------------*
*& Report Z_S05_SCHLEIFEN1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SCHLEIFEN1.
DATA LV_i type i VALUE 1.
DATA lv_times TYPE i VALUE 5.


WRITE: /'Do Schleife'.
"DO SCHLEIFE
DO lv_times TIMES.

  WRITE: / lv_i.
  ADD 10 TO lv_i.
  if lv_i GT 30.
    EXIT.  "Abbruchbedienung"
    ENDIF.

    "add 10 to lv_times.




  ENDDO.


 WRITE: /'While Schleife'.



  "W´WHILE SCHLEIFE

   lv_times = 30.

  WHILE lv_times GE 0.


   SUBTRACT 1 FROM lv_times.


    DATA(lv_rest) = lv_times MOD 2.

    IF lv_rest IS INITIAL.
      CONTINUE.

      ENDIF.

   WRITE: / lv_times.

    ENDWHILE.


    ULINE.

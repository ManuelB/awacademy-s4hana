*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE3A
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_XPROBE3A.


TABLES ZAWS05_PROBE1.
DATA ls_weur TYPE ZAWS05_PROBE1.
DATA lt_weur TYPE TABLE OF ZAWS05_PROBE1.



LOOP AT lt_weur ASSIGNING FIELD-SYMBOL(<nachname2>) WHERE nname EQ 'JOHNSON'.
  IF <nachname2>-nname EQ 'JOHNSON'.
    <nachname2>-nname = 'Röhr'.
    ENDIF.
    WRITE: <nachname2>-nname.
    ENDLOOP.

*&---------------------------------------------------------------------*
*& Report ZS04_WAEHRUNGSUMRECHNER_TAB (A11)
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_a11_waehrungsumr_tab_tcv.

DATA: a   TYPE p VALUE 0,
      b   TYPE p VALUE 0,
      res TYPE p LENGTH 6 DECIMALS 2.


SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-100.

*  SELECTION-SCREEN COMMENT 1(79) TEXT-101.

  SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.

    PARAMETERS p_curr TYPE tcurr_curr.

  SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN END OF BLOCK a.


TABLES tcurv.

START-OF-SELECTION.

  SELECT fcurr, tcurr, ukurs
    FROM tcurr
    WHERE tcurr~kurst = 'EURO'
    AND tcurr~tcurr = 'EUR'
    INTO TABLE @DATA(ausgabe).

  cl_demo_output=>display( ausgabe ).


  LOOP AT ausgabe INTO DATA(itab) WHERE fcurr EQ p_curr.
  ENDLOOP.



  IF sy-subrc <> 0.
    WRITE: / 'Zum angegebenen Währungsschlüssel wurden keine Einträge gefunden!' COLOR COL_NEGATIVE.
  ELSE.



    WRITE:(9) p_curr CENTERED COLOR COL_KEY.
    WRITE '|'.

    DO 11 TIMES.
      a = sy-index - 1.
      WRITE: (9) a COLOR COL_KEY, '|'.
    ENDDO.

    DO 11 TIMES.
      ULINE.
      a = 0.
      WRITE: (9) b COLOR COL_KEY, '|'.
      DO 11 TIMES.
        res = ( a + b ) / itab-ukurs. WRITE: (9) res, '|'.


        a = a + 1.
      ENDDO.
      a = 0.
      b = b + 10.
    ENDDO.

    ULINE.

  ENDIF.

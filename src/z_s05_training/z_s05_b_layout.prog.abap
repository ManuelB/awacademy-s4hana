REPORT Z_S05_B_LAYOUT .

*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


*
*TYPES:
*  t_summe TYPE p LENGTH 6 DECIMALS 2,
*  t_par   TYPE c LENGTH 15.
*
*DATA:
*  TYPE t_summe,
*  TYPE t_summe,
*  TYPE t_summe,
*  TYPE t_summe.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
*
*  PARAMETERS:
*     TYPE t_summe DEFAULT '',
*       TYPE t_par DEFAULT ''.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
*
*  PARAMETERS:
*
*     TYPE t_summe DEFAULT '',
*       TYPE t_par DEFAULT ''.
*
*
*SELECTION-SCREEN END OF BLOCK b2.
*
*PERFORM  USING  CHANGING .
*PERFORM  USING  CHANGING .
*
*IF  LE 0 OR  LE 0.
*  WRITE: 'Fehler! Uberprüfen Sie bitte Ihre Eingabe.' COLOR COL_NEGATIVE.
*ELSE.
*
*  WRITE:
*  / |:       {  }|,
*  / |:           {  }|,
*  /22 '',
*  / | :       {  }|,
*  /22 '=',
*  / | :           {  }|.
*  ULINE.
*
*  WRITE:
*  / |Warentyp 2:      {  }|,
*  / |Brutto 2:          {  }|,
*  /22 '-',
*  / |MWS Betrag 2 :      {  }|,
*  /22 '=',
*  / |Netto 2 :          {  }|.
*
*ENDIF.
*
*
*FORM  USING  CHANGING .
*
*  CASE .
*    WHEN ''.
* mws = brutto * ''.
* netto = brutto - mws.
*    WHEN ''.
* mws = brutto * ''.
* netto = brutto - mws.
* when others.
*   WRITE: / 'Fehler! Falsches .' color COL_NEGATIVE.a
*   ENDCASE.
*
*   ENDFORM.

*&---------------------------------------------------------------------*
*& Report Z_S05_UEBUNG6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_uebung6.

TYPES:
  t_summe TYPE p LENGTH 8 DECIMALS 2,
  t_wkurs TYPE p LENGTH 8 DECIMALS 6,
  t_par   TYPE c LENGTH 3.

DATA:
  gebuehr_vor1  TYPE t_summe,
  gebuehr_nach1 TYPE t_summe,
  wekurs1       TYPE t_wkurs,
  summe1        TYPE t_summe,

  gebuehr_vor2  TYPE t_summe,
  gebuehr_nach2 TYPE t_summe,
  wekurs2       TYPE t_wkurs,
  summe2        TYPE t_summe,

  gebuehr_vor3  TYPE t_summe,
  gebuehr_nach3 TYPE t_summe,
  wekurs3       TYPE t_wkurs,
  summe3        TYPE t_summe.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  PARAMETERS:
    p_euro1  TYPE t_summe DEFAULT 15,
    p_waehr1 TYPE t_par DEFAULT 'AUD'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS:

    p_euro2  TYPE t_summe DEFAULT 20,
    p_waehr2 TYPE t_par DEFAULT 'CAD'.


SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

  PARAMETERS:

    p_euro3  TYPE t_summe DEFAULT 360,
    p_waehr3 TYPE t_par DEFAULT 'GBP'.


SELECTION-SCREEN END OF BLOCK b3.


IF p_euro1 LE 0 OR p_euro2 LE 0 OR p_euro3 LE 0.
  WRITE: 'Fehler! Summe in EUR kann nicht 0 oder weniger sein.'.
ELSE.


  PERFORM rechnen USING p_euro1 p_waehr1 CHANGING gebuehr_vor1 gebuehr_nach1 wekurs1 summe1.
  "PERFORM ausgabe USING  p_euro1 p_waehr1 gebuehr_vor1 gebuehr_nach1 wekurs1 summe1.

  PERFORM rechnen USING p_euro2 p_waehr2 CHANGING gebuehr_vor2 gebuehr_nach2 wekurs2 summe2.
  "PERFORM ausgabe USING  p_euro2 p_waehr2 gebuehr_vor1 gebuehr_nach2 wekurs2 summe2.

  PERFORM rechnen USING p_euro3 p_waehr3 CHANGING gebuehr_vor3 gebuehr_nach3 wekurs3 summe3.
  "PERFORM ausgabe USING  p_euro3 p_waehr3 gebuehr_vor3 gebuehr_nach3 wekurs3 summe3.


ENDIF.

 WRITE:
   / |  { p_waehr1 } | color COL_HEADING,
   / |  Gebührenrechner |,
 / | Summe: { p_euro1 }, €|,
 / |          -       |,
 / | Gebühr: { gebuehr_vor1 }, €|,
  / |          =       |,
 / | Summe mit Gebühr: { gebuehr_nach1 }, €| color COL_KEY,
/,
   / |  Währungsumrechner |,
  / | Summe: { gebuehr_nach1 }, €|,
  / | in Währung: { p_waehr1 } |,
  / | Weschelkurs: 1€ = { wekurs1 } |.
WRITE:
  / | Total in { p_waehr1 } =  { summe1 }| color COL_TOTAL..
   ULINE.
   ULINE.

    WRITE:
   / |  { p_waehr2 } | color COL_HEADING,
   / |  Gebührenrechner |,
 / | Summe: { p_euro2 }, €|,
 / |          -       |,
 / | Gebühr: { gebuehr_vor2 }, €|,
  / |          =       |,
 / | Summe mit Gebühr: { gebuehr_nach2 }, €| color COL_KEY,
/,
   / |  Währungsumrechner |,
  / | Summe: { gebuehr_nach2 }, €|,
  / | in Währung: { p_waehr2 } |,
  / | Weschelkurs: 1€ = { wekurs2 } |.
WRITE:
  / | Total in { p_waehr2 } =  { summe2 } | color COL_TOTAL..


    ULINE.
   ULINE.

       WRITE:
   / |  { p_waehr3 } | color COL_HEADING,
   / |  Gebührenrechner |,
 / | Summe: { p_euro3 }, €|,
 / |          -       |,
 / | Gebühr: { gebuehr_vor3 }, €|,
  / |          =       |,
 / | Summe mit Gebühr: { gebuehr_nach3 }, €| color COL_KEY,
/,
   / |  Währungsumrechner |,
  / | Summe: { gebuehr_nach3 }, €|,
  / | in Währung: { p_waehr3 } |,
  / | Weschelkurs: 1€ = { wekurs3 } |.
WRITE:
  / | Total in { p_waehr3 } =  { summe3 } | color COL_TOTAL.






FORM rechnen USING p_euro p_waehr CHANGING gebuehr_vor gebuehr_nach wekurs summe.
  CASE p_waehr.
    WHEN 'AUD'.
      gebuehr_vor = ( p_euro * '0.05').
      gebuehr_nach = ( p_euro -  gebuehr_vor  ).
      wekurs = '0.75109'.
      summe = gebuehr_nach * wekurs.
    WHEN 'CAD'.
      gebuehr_vor = ( p_euro * '0.05').
      gebuehr_nach = ( p_euro -  gebuehr_vor  ).
      wekurs = '1.43864 '.
      summe = gebuehr_nach * wekurs.
    WHEN 'GBP'.
      gebuehr_vor = ( p_euro * '0.05').
      gebuehr_nach = ( p_euro -  gebuehr_vor  ).
      wekurs = '0.62035 '.
      summe = gebuehr_nach * wekurs.
    WHEN OTHERS.
      WRITE: 'Fehler! Falsches Weschelkurs'.
  ENDCASE.
ENDFORM.

*FORM ausgabe USING  p_euro p_waehr gebuehr_vor gebuehr_nach wekurs summe.
*  WRITE:
*   / |  { p_waehr } |,
*   / |  Gebührenrechner |,
* / | Summe: { p_euro }, €|,
* / |          -       |,
* / | Gebühr: { gebuehr_vor }, €|,
*  / |          =       |,
* / | Summe mit Gebühr: { gebuehr_nach }, €|,
*
*   / |  Währungsumrechner |,
*  / | Summe: { gebuehr_nach }, €|,
*  / | in Währung: { p_waehr } |,
*  / | Weschelkurs: 1€ = { wekurs } |,
*  / | Total in { p_waehr } =  { summe } |.
*  ULINE.
*  ULINE.
*
*ENDFORM.

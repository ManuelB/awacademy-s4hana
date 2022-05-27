*&---------------------------------------------------------------------*
*& Report ZS04_TASCHENRECHNER_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_tr_form_fuba_datel.


INCLUDE ZS04_INCLUDE_DEMO_TR.

**Daten: Deklarationen für Selektionsbild und Berechnungen als Include auslagern.
***********************************************************************
**Eingabefelder:
*
*SELECTION-SCREEN BEGIN OF BLOCK e WITH FRAME.
*
**  SELECTION-SCREEN BEGIN OF BLOCK e0 WITH FRAME.
**    PARAMETERS:
**    op TYPE foperator VALUE CHECK.
**  SELECTION-SCREEN END OF BLOCK e0.
*
*  SELECTION-SCREEN BEGIN OF BLOCK e1 WITH FRAME.
*    PARAMETERS:
*      a1  TYPE betrag11  DEFAULT 3,
*      op1 TYPE foperator VALUE CHECK DEFAULT '/',
*      b1  TYPE betrag11  DEFAULT 0.
*  SELECTION-SCREEN END OF BLOCK e1.
*
*  SELECTION-SCREEN BEGIN OF BLOCK e2 WITH FRAME.
*    PARAMETERS:
*      a2  TYPE betrag11  DEFAULT 5,
*      op2 TYPE foperator VALUE CHECK DEFAULT 'R',
*      b2  TYPE betrag11  DEFAULT 7.
*  SELECTION-SCREEN END OF BLOCK e2.
*
*SELECTION-SCREEN END OF BLOCK e.
*
*
*
***********************************************************************
**Typisierung des Ergebnis (res = result):
*
*DATA: res TYPE betrag11.



**********************************************************************
*1. Rechnung:

WRITE: / 'Rechnung 1:'.
ULINE: /(12).

*Über FORM/PERFORM:
*PERFORM rechnen USING a1 op1 b1 CHANGING res.


*Über Einbindung eines Funktionsbaustein (FUBA)
CALL FUNCTION 'ZS04_FUBA_RECHNEN_DATEL'
  EXPORTING
    i_a               = a1
    i_op              = op1
    i_b               = b1
  IMPORTING
    e_res             = res
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 3
    OTHERS            = 4.


*Ergebnis- und Fehlerausgabe über IF-Schleife.
IF sy-subrc <> 0.
  WRITE: / 'Fehlercode:', sy-subrc.
  IF sy-subrc EQ 1.
    WRITE:  '(Division durch "0" nicht möglich!)'(001) COLOR COL_NEGATIVE.
  ENDIF.
  IF sy-subrc EQ 2.
    WRITE: TEXT-002 COLOR COL_NEGATIVE.
  ENDIF.
  IF sy-subrc EQ 3.
    WRITE: '(Negatives Argument bei Quadratwurzel!)' COLOR COL_NEGATIVE.
  ENDIF.
ELSEIF op1 EQ 'R'.
  PERFORM ausgabe_r USING a1 op1 res.
ELSE.
  PERFORM ausgabe USING a1 op1 b1 res.
ENDIF.



**********************************************************************
*Leerzeile, Trennlinie, Leerzeile

SKIP.
ULINE.
SKIP.



**********************************************************************
*2.Rechnung:

WRITE: / 'Rechnung 2:'.
ULINE: /(12).

*Über FORM/PERFORM:
*PERFORM rechnen USING a2 op2 b2 CHANGING res.


*Über Einbindung eines Funktionsbaustein (FUBA)
CALL FUNCTION 'ZS04_FUBA_RECHNEN_DATEL'
  EXPORTING
    i_a               = a2
    i_op              = op2
    i_b               = b2
  IMPORTING
    e_res             = res
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 3
    OTHERS            = 4.



*Ergebnis- und Fehlerausgabe über CASE.
IF sy-subrc <> 0.
  WRITE: / 'Fehlercode:', sy-subrc.
  CASE sy-subrc.
    WHEN 1. WRITE: '(Division durch "0" nicht möglich!)' COLOR COL_NEGATIVE.
    WHEN 2. WRITE: '(Ungültiger Operator!)' COLOR COL_NEGATIVE.
    WHEN 3. WRITE: '(Negatives Argument bei Quadratwurzel!)' COLOR COL_NEGATIVE.
    WHEN 4. WRITE: '(Anderer Fehler!)' COLOR COL_NEGATIVE.
    WHEN OTHERS. "Coming soon.
      WRITE: 'Neuer Fehler: Noch nicht definiert' COLOR COL_NEGATIVE.
  ENDCASE.
ELSEIF op2 = 'R'.
  PERFORM ausgabe_r USING a2 op2 res.
ELSE.
  PERFORM ausgabe USING a2 op2 b2 res.
ENDIF.



**********************************************************************
*RechnenFORM

*FORM rechnen USING a op b CHANGING res.
*  CASE op.
*    WHEN '+'. res = a + b.
*    WHEN '-'. res = a - b.
*    WHEN '*'. res = a * b.
*    WHEN '/'. res = a / b.
*  ENDCASE.
*ENDFORM.



**********************************************************************
*AusgabeFORM:

FORM ausgabe USING a op b res.
  WRITE: /3 a,
         / op ,b.
  ULINE: /3(29).
  WRITE: /3 res.
ENDFORM.


FORM ausgabe_r USING a op res.
  WRITE: /3 a,
         / op.
  ULINE: /3(29).
  WRITE: /3 res.
ENDFORM.

*&---------------------------------------------------------------------*
*& Report ZSD_GRP1_REP_KALKULATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_grp1_rep_kalkulation.

SELECTION-SCREEN BEGIN OF BLOCK kalk WITH FRAME TITLE TEXT-100.


  SELECTION-SCREEN BEGIN OF BLOCK ek WITH FRAME TITLE TEXT-101.

    PARAMETERS: p_ekpr TYPE betrag11.

  SELECTION-SCREEN END OF BLOCK ek.


  SELECTION-SCREEN BEGIN OF BLOCK tax WITH FRAME TITLE TEXT-102.

    PARAMETERS: p_tax7  RADIOBUTTON GROUP rb_1,
                p_tax19 RADIOBUTTON GROUP rb_1.

  SELECTION-SCREEN END OF BLOCK tax.


  SELECTION-SCREEN BEGIN OF BLOCK ve WITH FRAME TITLE TEXT-103.

    PARAMETERS: p_ve_st  RADIOBUTTON GROUP rb_2,
                p_ve_pak RADIOBUTTON GROUP rb_2.

  SELECTION-SCREEN END OF BLOCK ve.


SELECTION-SCREEN END OF BLOCK kalk.


DATA: lv_ekbpreis TYPE betrag11,
      lv_vkpreis  TYPE betrag11,
      lv_tax      TYPE p LENGTH 2 DECIMALS 2,
      lv_ve       TYPE p LENGTH 2 DECIMALS 2.


**********************************************************************
START-OF-SELECTION.
**********************************************************************

**********************************************************************
*Auswahl der Steuerrate.

  IF p_tax7 = 'X'.
    lv_tax = '1.07'.
  ELSEIF p_tax19 = 'X'.
    lv_tax = '1.19'.
  ELSE.
  ENDIF.


**********************************************************************
*Auswahl der Verkaufseinheit.

  IF p_ve_st = 'X'.
    lv_ve = '1.80'.
  ELSEIF p_ve_pak = 'X'.
    lv_ve = '1.40'.
  ELSE.
  ENDIF.

**********************************************************************

  PERFORM kalk USING p_ekpr lv_tax lv_ve CHANGING lv_vkpreis.
  PERFORM ausgabe USING p_ekpr lv_tax lv_ve CHANGING lv_vkpreis.

**********************************************************************

FORM kalk USING p_ekpr lv_tax lv_ve CHANGING lv_vkpreis.
  lv_ekbpreis = p_ekpr * lv_tax.
  lv_vkpreis = lv_ekbpreis * lv_ve.
ENDFORM.

FORM ausgabe USING p_ekpr lv_tax lv_ve CHANGING lv_vkpreis.
  WRITE: / 'Einkaufspreis Netto:', p_ekpr,
  / 'Einkaufspreis Brutto:', lv_ekbpreis,
  / 'Kalkulierter Verkaufspreis:', lv_vkpreis.
ENDFORM.

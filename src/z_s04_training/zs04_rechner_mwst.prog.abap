*&---------------------------------------------------------------------*
*& Report ZS04_RECHNER_MWST.
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_rechner_mwst.

SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME.
  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
    PARAMETERS:
      p1 TYPE p LENGTH 5 DECIMALS 2 DEFAULT 100,
      p2 TYPE p LENGTH 5 DECIMALS 2 DEFAULT 50.

  SELECTION-SCREEN END OF BLOCK b1.


  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
    PARAMETERS p_LM RADIOBUTTON GROUP rb_1.
    PARAMETERS p_HW RADIOBUTTON GROUP rb_1.
  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF BLOCK b.



DATA lv_ergebnis1 TYPE p DECIMALS 2.
DATA lv_ergebnis2 TYPE p DECIMALS 2.
DATA lv_mwst1 TYPE p DECIMALS 2.
DATA lv_mwst2 TYPE p DECIMALS 2.


IF p_lm = 'X'.
  WRITE: / 'Lebensmittel'.
  ULINE.
  lv_ergebnis1 = p1 / '1.07'.
  lv_mwst1 = p1 - lv_ergebnis1.
  WRITE: / 'Nettobetrag 1:', lv_ergebnis1, 'EUR', '|', 'MwSt 1:',lv_mwst1, 'EUR'.
  ULINE.
  lv_ergebnis2 = p2 / '1.07'.
  lv_mwst2 = p2 - lv_ergebnis2.
  WRITE: / 'Nettobetrag 2:', lv_ergebnis2, 'EUR', '|', 'MwSt 2:',lv_mwst2, 'EUR'.
  ULINE.


ELSEIF p_hw = 'X'.
  WRITE: / 'Handelsware'.
  ULINE.
  lv_ergebnis1 = p1 / '1.19'.
  lv_mwst1 = p1 - lv_ergebnis1.
  WRITE: / 'Nettobetrag 1:', lv_ergebnis1, 'EUR', '|', 'MwSt 1:',lv_mwst1, 'EUR'.
  ULINE.
  lv_ergebnis2 = p2 / '1.19'.
  lv_mwst2 = p2 - lv_ergebnis2.
  WRITE: / 'Nettobetrag 2:', lv_ergebnis2, 'EUR', '|', 'MwSt 2:',lv_mwst2, 'EUR'.
  ULINE.
ENDIF.

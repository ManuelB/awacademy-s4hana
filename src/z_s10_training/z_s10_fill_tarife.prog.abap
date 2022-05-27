*&---------------------------------------------------------------------*
*& Report Z_S10_FILL_TARIFE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S10_FILL_TARIFE.



SELECT * FROM ZISU_FP_TARIFF INTO TABLE @DATA(lt_tarif) .
MESSAGE: |SELECT abgeschlossen.| TYPE 'S'.



IF NOT lt_tarif IS INITIAL.
  INSERT ZGRP3_TARIFE FROM TABLE lt_tarif.

  IF sy-subrc EQ 0.
    MESSAGE: |Daten aus ZISU_FP_TARIFF wurden in ZGRP3_TARIFE kopiert.| TYPE 'S'.
  ELSE.
    MESSAGE: |Kopiervorgang nicht erfolgreich [MODIFY].| TYPE 'S'.
  ENDIF.
ELSE.
  MESSAGE: |Kopiervorgang nicht erfolgreich [Keine Daten erhalten].| TYPE 'S'.
ENDIF.

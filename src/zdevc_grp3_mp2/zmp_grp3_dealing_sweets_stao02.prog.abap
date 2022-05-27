*----------------------------------------------------------------------*
***INCLUDE ZMP_GRP3_DEALING_SWEETS_STAO02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_2010 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2010 OUTPUT.
  SET PF-STATUS 'PF2010'.
* SET TITLEBAR 'xxx'.
  SELECT SINGLE FOR UPDATE filialnummer, filialbezeichnung, strasse, plz, ort, telefon
     FROM  zgrp3_filstamm
     WHERE filialnummer = @zgrp3_filstamm-filialnummer
     INTO @DATA(ls_fil).
  IF sy-subrc = 0.
    zgrp3_filstamm-filialnummer = ls_fil-filialnummer.
    zgrp3_filstamm-filialbezeichnung = ls_fil-filialbezeichnung.
    zgrp3_filstamm-ort = ls_fil-ort.
    zgrp3_filstamm-plz = ls_fil-plz.
    zgrp3_filstamm-strasse = ls_fil-strasse.
    zgrp3_filstamm-telefon = ls_fil-telefon.
  ELSE.
      MESSAGE e015.
  ENDIF.

ENDMODULE.

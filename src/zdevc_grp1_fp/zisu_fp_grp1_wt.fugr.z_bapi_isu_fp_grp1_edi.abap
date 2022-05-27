FUNCTION z_bapi_isu_fp_grp1_edi.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_AUFTNR) TYPE  ZSD_GRP1_FP_KS-KDNR
*"     VALUE(I_VORNAME) TYPE  ZSD_GRP1_FP_WT-VORNAME
*"     VALUE(I_NACHNAME) TYPE  ZSD_GRP1_FP_WT-NACHNAME
*"  EXPORTING
*"     REFERENCE(EX_TEXT) TYPE  PSSCT_DBS_ENTITY_SEL_CONF_T
*"----------------------------------------------------------------------




  DATA: ls_text TYPE popuptext,
        lt_text LIKE TABLE OF ls_text.

  SELECT kdnr, zaehlernr, zaehlerstand, anrede, ks~geburtsdatum, strasse, hsnum, plz, ort, wechseldatum
    FROM zsd_grp1_fp_ks as ks
    LEFT JOIN zsd_grp1_fp_wt as wt ON ks~kdnr = wt~auftnr
    WHERE kdnr = @i_auftnr INTO @DATA(ls_ks).


ENDSELECT.

*  ls_text-topofpage = 1.
*  ls_text-hell = 'X'.

  ls_text-text = |Kundenspezifische Daten für den Anbieterwechsel:|.
  APPEND ls_text TO lt_text.

  ls_text-text = |Auftragsnummer: { i_auftnr }|.
  APPEND ls_text TO lt_text.

  ls_text-text = |Personenbezogene Daten:|.
  APPEND ls_text TO lt_text.

  ls_text-text = |Vorname: { i_vorname }|.
  APPEND ls_text TO lt_text.

  ls_text-text = |Nachname: { i_nachname }|.
  APPEND ls_text TO lt_text.

    ls_text-text = |Geburtsdatum: { zsd_grp1_fp_ks-geburtsdatum }|.
  APPEND ls_text TO lt_text.



  ex_text = lt_text.


ENDFUNCTION.

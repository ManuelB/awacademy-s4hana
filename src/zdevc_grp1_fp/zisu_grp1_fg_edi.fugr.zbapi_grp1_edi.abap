FUNCTION zbapi_grp1_edi.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_AUFTNR) TYPE  ZSD_GRP1_FP_WT-AUFTNR
*"     VALUE(I_KDNR) TYPE  ZSD_GRP1_FP_KS-KDNR OPTIONAL
*"     VALUE(I_WT) TYPE  ZSD_GRP1_FP_WT
*"     VALUE(I_KS) TYPE  ZSD_GRP1_FP_KS
*"  EXPORTING
*"     VALUE(EX_TEXT) TYPE  PSSCT_DBS_ENTITY_SEL_CONF_T
*"----------------------------------------------------------------------

  DATA: ls_text TYPE popuptext,
        lt_text LIKE TABLE OF ls_text.

  SELECT auftnr, anrede, wt~vorname, wt~nachname, wt~geburtsdatum, strasse, hsnum,
    plz, ort, zaehlernr, zaehlerstand, wechseldatum, altanb, neuanb, neutarif
    FROM zsd_grp1_fp_wt AS wt
    LEFT JOIN zsd_grp1_fp_ks AS ks ON wt~auftnr = ks~kdnr
    WHERE auftnr = @i_auftnr
    AND kdnr = @i_auftnr
    INTO @DATA(ls_bapi).
  ENDSELECT.

  ls_text-text = |KDANR:{ ls_bapi-auftnr }'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |NEUANB+ALTANB:3+{ ls_bapi-neuanb }+{ ls_bapi-altanb }+060620:0931+1++1234567'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |UNH+1+NEUTARIF:{ ls_bapi-neutarif }:D:96A:UN'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |ZNR:{ ls_bapi-zaehlernr }+ZST:{ ls_bapi-zaehlerstand }'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |WDT+4:{ ls_bapi-wechseldatum }'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |NAD+BY+++{ ls_bapi-anrede }+{ ls_bapi-vorname }+{ ls_bapi-nachname }+{ ls_bapi-strasse }+{ ls_bapi-hsnum }+{ ls_bapi-plz }+{ ls_bapi-ort }+++'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |UNS+S'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |MSG+++Wechsel+erfolgreich+durchgeführt+++'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |CNT+2:1'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |UNT+9+1'|.
  APPEND ls_text TO lt_text.
  ls_text-text = |UNZ+1+1234567'|.
  APPEND ls_text TO lt_text.

  ex_text = lt_text.

ENDFUNCTION.

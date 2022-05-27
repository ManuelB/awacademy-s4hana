FUNCTION bapi_isu_fp_grp1_edi_nachricht.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_AUFTNR) TYPE  ZSD_GRP1_FP_KS-KDNR
*"     VALUE(I_ZAEHLERNUMMER) TYPE  ZSD_GRP1_FP_KS-ZAEHLERNR
*"     VALUE(I_ZAEHLERSTAND) TYPE  ZSD_GRP1_FP_KS-ZAEHLERSTAND
*"     VALUE(I_ANREDE) TYPE  ZSD_GRP1_FP_KS-ANREDE
*"     VALUE(I_VORNAME) TYPE  ZSD_GRP1_FP_WT-VORNAME
*"     VALUE(I_NACHNAME) TYPE  ZSD_GRP1_FP_WT-NACHNAME
*"     VALUE(I_GEBURTSDATUM) TYPE  ZSD_GRP1_FP_WT-GEBURTSDATUM
*"     VALUE(I_STRASSE) TYPE  ZSD_GRP1_FP_KS-STRASSE
*"     VALUE(I_HAUSNUMMER) TYPE  ZSD_GRP1_FP_KS-HSNUM
*"     VALUE(I_POSTLEITZAHL) TYPE  ZSD_GRP1_FP_KS-PLZ
*"     VALUE(I_ORT) TYPE  ZSD_GRP1_FP_KS-ORT
*"     VALUE(I_WECHSELDATUM) TYPE  ZSD_GRP1_FP_KS-WECHSELDATUM
*"  EXPORTING
*"     REFERENCE(EX_TEXT) TYPE  PSSCT_DBS_ENTITY_SEL_CONF_T
*"  TABLES
*"      LINES STRUCTURE  POPUPTEXT
*"  CHANGING
*"     REFERENCE(WECHSELTABELLE) TYPE  ZSD_GRP1_FP_WT
*"     REFERENCE(KUNDENSTAMMTABELLE) TYPE  ZSD_GRP1_FP_KS
*"     REFERENCE(LT_WECHSEL) TYPE  ZSD_GRP1_LT_WECHSEL
*"  EXCEPTIONS
*"      INPUT_INVALIDE
*"----------------------------------------------------------------------
*  DATA: lv_auftnr TYPE zsd_grp1_fp_wt-auftnr.
**        lt_wechsel type table of ZSD_GRP1_FP_KS.
**  data lt_edinachricht type zsd_grp1_fp_ks.
*
*
*clear LT_WECHSEL.
*  SELECT single status
*    FROM zsd_grp1_fp_wt
*    where status = 4
*    into.
*
*    SELECT ks~zaehlernr, ks~zaehlerstand, ks~anrede, ks~vorname, ks~nachname, ks~geburtsdatum, ks~strasse, ks~plz, ks~ort, ks~hsnum, ks~wechseldatum
*      FROM zsd_grp1_fp_ks AS ks
*      LEFT JOIN zsd_grp1_fp_wt AS wt ON ks~kdnr = wt~auftnr
*      AND ks~vorname = wt~vorname
*      AND ks~nachname = wt~nachname
*      AND ks~geburtsdatum = wt~geburtsdatum
*      WHERE wt~auftnr = @lv_auftnr
*      INTO CORRESPONDING FIELDS OF table @LT_wechsel.


  DATA: ls_text TYPE c LENGTH 255,
        lt_text LIKE TABLE OF ls_text.

*  DATA: ls_text TYPE popuptext,
*        lt_text TYPE TABLE OF popuptext.

  ls_text = |Kundenspezifische Daten für den Anbieterwechsel:|.
  APPEND ls_text TO lt_text.
  ls_text = |Auftragsnummer: { i_auftnr }|.
  APPEND ls_text TO lt_text.
  ls_text = |Zählernummer: { i_zaehlernummer }|.
  APPEND ls_text TO lt_text.
  ls_text = |Aktueller Zählerstand: { i_zaehlerstand }|.
  APPEND ls_text TO lt_text.
  ls_text = |Wechseldatum: { i_wechseldatum }|.
  APPEND ls_text TO lt_text.

  ls_text = |Personenbezogene Daten:|.
  APPEND ls_text TO lt_text.
  ls_text = |Anrede: { i_anrede }|.
  APPEND ls_text TO lt_text.
  ls_text = |Vorname: { i_vorname }|.
  APPEND ls_text TO lt_text.
  ls_text = |Nachname: { i_nachname }|.
  APPEND ls_text TO lt_text.
  ls_text = |Geburtsdatum: { i_geburtsdatum }|.
  APPEND ls_text TO lt_text.
  ls_text = |Straße: { i_strasse }|.
  APPEND ls_text TO lt_text.
  ls_text = |Hausnummer: { i_hausnummer }|.
  APPEND ls_text TO lt_text.
  ls_text = |Postleitzahl: { i_postleitzahl }|.
  APPEND ls_text TO lt_text.
  ls_text = |Wohnort: { i_ort }|.
  APPEND ls_text TO lt_text.
  ls_text = |Wechseldatum: { i_wechseldatum }|.
  APPEND ls_text TO lt_text.

  ex_text = lt_text.







ENDFUNCTION.

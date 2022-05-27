class ZCL_SD_GRP1_NEUKUNDE definition
  public
  final
  create public .

public section.

  data KUNDENDATEN type ZSD_GRP1_FP_KS .

  class-events TARIFWECHSEL_BEANTRAGT
    exporting
      value(AUFTRAGSNUMMER) type ZSD_GRP1_FP_WT-AUFTNR
      value(VORNAME) type ZSD_GRP1_FP_WT-VORNAME
      value(NACHNAME) type ZSD_GRP1_FP_WT-NACHNAME
      value(GEBURTSDATUM) type ZSD_GRP1_FP_WT-GEBURTSDATUM
      value(STATUS) type ZSD_GRP1_FP_WT-STATUS .

  class-methods TARIFE_VERGLEICHEN .
  class-methods ANBIETER_WECHSELN
    importing
      value(IM_ANREDE) type ZCS_GRP1_ANREDE
      value(IM_VORNAME) type P01_BVV_VORNAME
      value(IM_NACHNAME) type P01_BVV_ZUNAME
      value(IM_GEBURTSDATUM) type DATN
      value(IM_STRASSE) type AD_STREET
      value(IM_HAUSNR) type AD_HSNM1
      value(IM_PLZ) type AD_PSTCD1
      value(IM_ORT) type AD_CITY1
      value(IM_WECHSELDATUM) type DATN
      value(IM_ZAHLERNR) type OIG_METSEQ
      value(IM_ZAEHLERSTD) type OIG_METEND
      value(IM_ALTANBIETER) type ZALTANBIETER
      value(IM_NEUANBIETER) type ZANBIETER
      value(IM_NEUTARIF) type ZTARIFBEZ
    exporting
      value(EX_AUFNR) type KDANR .
  class-methods STATUS_ANFRAGEN_BEANTRAGEN .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_GRP1_NEUKUNDE IMPLEMENTATION.


 METHOD anbieter_wechseln.

   DATA: ls_wechsel TYPE zsd_grp1_fp_ks,
         ls_status  TYPE zsd_grp1_fp_wt.

   ls_wechsel-anrede = im_anrede.
   ls_wechsel-vorname = im_vorname.
   ls_wechsel-nachname = im_nachname.
   ls_wechsel-geburtsdatum = im_geburtsdatum.
   ls_wechsel-strasse = im_strasse.
   ls_wechsel-hsnum = im_hausnr.
   ls_wechsel-plz = im_plz.
   ls_wechsel-ort = im_ort.
   ls_wechsel-wechseldatum = im_wechseldatum.
   ls_wechsel-zaehlernr = im_zahlernr.
   ls_wechsel-zaehlerstand = im_zaehlerstd.
   ls_wechsel-altanb = im_altanbieter.
   ls_wechsel-neuanb = im_neuanbieter.
   ls_wechsel-neutarif = im_neutarif.

   SELECT MAX( kdnr ) FROM zsd_grp1_fp_ks INTO ls_wechsel-kdnr.
   ls_wechsel-kdnr = ls_wechsel-kdnr + 1.
   ex_aufnr = ls_wechsel-kdnr.

   INSERT INTO zsd_grp1_fp_ks VALUES ls_wechsel.


   IF sy-subrc = 0.
     ls_status-auftnr = ls_wechsel-kdnr.
     ls_status-vorname = ls_wechsel-vorname.
     ls_status-nachname = ls_wechsel-nachname.
     ls_status-geburtsdatum = ls_wechsel-geburtsdatum.
     ls_status-status = '1'.

          RAISE EVENT tarifwechsel_beantragt
        EXPORTING
          auftragsnummer = ls_status-auftnr
          vorname        = ls_status-vorname
          nachname       = ls_status-nachname
          geburtsdatum   = ls_status-geburtsdatum
          status         = ls_status-status
          .
     INSERT INTO zsd_grp1_fp_WT VALUES ls_status.


   ENDIF.
   CLEAR ls_wechsel.

 ENDMETHOD.


  method STATUS_ANFRAGEN_BEANTRAGEN.
  endmethod.


  method TARIFE_VERGLEICHEN.
  endmethod.
ENDCLASS.

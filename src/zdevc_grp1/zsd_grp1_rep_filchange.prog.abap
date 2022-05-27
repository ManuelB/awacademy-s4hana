REPORT zsd_grp1_rep_filchange.

 "Filialstamm
  SELECTION-SCREEN BEGIN OF BLOCK b WITH FRAME TITLE TEXT-201.
    PARAMETERS: p_filnr TYPE zsd_grp1_fsnu,
                p_filna TYPE zsd_grp1_fsna,
                p_ort   TYPE ad_city1,
                p_stras TYPE ad_street,
                p_plz   TYPE ad_pstcd1,
                p_tel   TYPE ad_tlnmbr1.
  SELECTION-SCREEN END OF BLOCK b.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
        IF screen-name = 'P_FILNA' OR screen-name = '%_P_FILNA_%_APP_%-TEXT'
          OR screen-name = 'P_ORT' OR screen-name = '%_P_ORT_%_APP_%-TEXT'
          OR screen-name = 'P_STRAS' OR screen-name = '%_P_STRAS_%_APP_%-TEXT'
          OR screen-name = 'P_PLZ' OR screen-name = '%_P_PLZ_%_APP_%-TEXT'
          OR screen-name = 'P_TEL' OR screen-name = '%_P_TEL_%_APP_%-TEXT'.
*          screen-active = 0.
          screen-input = 0.
        ENDIF.
        MODIFY SCREEN.
  ENDLOOP.

**********************************************************************
*TOP
CLASS lcl_filiale DEFINITION.
  PUBLIC SECTION.
    METHODS:
      filiale_pflegen
        IMPORTING
          im_filnr   TYPE zsd_grp1_fsnu
          im_filname TYPE zsd_grp1_fsna
          im_ort     TYPE ad_city1
          im_strasse TYPE ad_street
          im_plz     TYPE ad_pstcd1
          im_tel     TYPE ad_tlnmbr1
        EXCEPTIONS
          pflegen_succ.
DATA: filsta TYPE zsd_grp1_fs.
  PRIVATE SECTION.
ENDCLASS.

**********************************************************************
*F01
CLASS lcl_filiale IMPLEMENTATION.

  METHOD filiale_pflegen.

filsta-filnr = im_filnr.
filsta-filname =  im_filname.
filsta-ort =  im_ort.
filsta-strasse =  im_strasse.
filsta-datum =  im_plz.
filsta-tel = im_tel.


  ENDMETHOD.

ENDCLASS.





**********************************************************************
*MODULE
START-OF-SELECTION.

  DATA(lo_filiale) = NEW lcl_filiale( ).

      lo_filiale->filiale_pflegen(
        EXPORTING
          im_filnr     = p_filnr
          im_filname   = p_filna
          im_ort       = p_ort
          im_strasse   = p_stras
          im_plz       = p_plz
          im_tel       = p_tel  ).

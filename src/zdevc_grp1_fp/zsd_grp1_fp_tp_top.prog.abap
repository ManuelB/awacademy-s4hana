*&---------------------------------------------------------------------*
*& Include ZSD_GRP1_FP_TP_TOP                       - Modulpool        ZSD_GRP1_FP_TARIFPFLEGE
*&---------------------------------------------------------------------*
PROGRAM zsd_grp1_fp_tarifpflege MESSAGE-ID zmsg_grp1_fp.

TABLES: zisu_fp_tarife.

CLASS lcl_eventlistener DEFINITION DEFERRED.

DATA: ls_tarife TYPE zisu_fp_tarife,
      lt_tarife TYPE TABLE OF zisu_fp_tarife,

*Vereinbarung von Variable und Tabelle für Veränderung der Spaltenbeschriftung auf dem ALV-Grid
      ls_fcat   TYPE lvc_s_fcat,
      lt_fcat   TYPE lvc_t_fcat,

*Vereinbarungen für Anzeigefelder des gewählten Anbieters/Tarifs
      felda     TYPE zisu_fp_tarife-anbietername,
      feldt     TYPE zisu_fp_tarife-anbietertarif,

*Vereinbarungen für ALV und Event Doppelklick
      cont1     TYPE REF TO cl_gui_custom_container,
      alv1      TYPE REF TO cl_gui_custom_alv_grid,
      my_event  TYPE REF TO lcl_eventlistener.

*Klasse für Event Doppelklick auf ALV-Grid
CLASS lcl_eventlistener DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS  handle_double_click FOR EVENT double_click OF cl_gui_custom_alv_grid
      IMPORTING e_row.
ENDCLASS.

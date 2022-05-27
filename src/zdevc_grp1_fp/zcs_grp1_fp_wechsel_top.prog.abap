*&---------------------------------------------------------------------*
*& Include ZCS_GRP1_FP_WECHSEL_TOP                  - Modulpool        ZCS_GRP1_FP_WECHSEL
*&---------------------------------------------------------------------*
PROGRAM zcs_grp1_fp_wechsel.

TABLES: zisu_fp_tarife, zsd_grp1_fp_ks, zsd_grp1_fp_wt.

CLASS lcl_eventlistener DEFINITION DEFERRED.

DATA: ls_tarife TYPE zisu_fp_tarife,
      lt_tarife TYPE TABLE OF zisu_fp_tarife,

      ls_fcat TYPE lvc_s_fcat,
      lt_fcat TYPE lvc_t_fcat,

      felda TYPE zisu_fp_tarife-anbietername,
      feldt TYPE zisu_fp_tarife-anbietertarif,

      cont1     TYPE REF TO cl_gui_custom_container,
      alv1      TYPE REF TO cl_gui_custom_alv_grid,
      dia1      TYPE REF TO cl_gui_dialogbox_container,
      my_event  TYPE REF TO lcl_eventlistener.


CLASS lcl_eventlistener DEFINITION.
  PUBLIC SECTION.
    METHODS:  handle_double_click FOR EVENT double_click OF cl_gui_custom_alv_grid
      IMPORTING e_row.
ENDCLASS.

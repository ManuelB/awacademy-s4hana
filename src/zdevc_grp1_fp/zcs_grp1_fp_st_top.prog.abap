PROGRAM zcs_grp1_fp_wechsel MESSAGE-ID zmsg_grp1_fp.

TABLES: zsd_grp1_fp_wt, zsd_grp1_fp_ks.

CLASS lcl_eventlistener DEFINITION DEFERRED.

DATA: lo_text_editor TYPE REF TO cl_gui_textedit,
      cont1          TYPE REF TO cl_gui_custom_container,
      editext        TYPE REF TO cl_gui_textedit,
      cont2          TYPE REF TO cl_gui_custom_container.

*Vereinbarungen für EDI-Nachricht
DATA: ls_text  TYPE c LENGTH 255,
      ls_text1 TYPE popuptext,
      lt_text2 LIKE TABLE OF ls_text,
      lt_text  LIKE TABLE OF ls_text1.

*Vereinbarungen für ALV und Event Doppelklick
DATA: ls_wt TYPE zsd_grp1_fp_wt,
      lt_wt TYPE TABLE OF zsd_grp1_fp_wt,
      contwt     TYPE REF TO cl_gui_custom_container,
      alvwt      TYPE REF TO cl_gui_custom_alv_grid,
      my_event  TYPE REF TO lcl_eventlistener.

DATA: feld1(34).

*Klasse für Event Doppelklick auf ALV-Grid
CLASS lcl_eventlistener DEFINITION.
  PUBLIC SECTION.
   CLASS-METHODS  handle_double_click FOR EVENT double_click OF cl_gui_custom_alv_grid
      IMPORTING e_row.
ENDCLASS.

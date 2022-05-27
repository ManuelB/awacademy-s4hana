*&---------------------------------------------------------------------*
*& Modulpool        Z_DEMO_INCLUDE_GRUPPE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE Z_S05_DEMO_INCLUDE_GRUPPETTOP.
*INCLUDE Z_DEMO_INCLUDE_GRUPPETOP                .    " Global Data

* INCLUDE Z_DEMO_INCLUDE_GRUPPEO01                .  " PBO-Modules
* INCLUDE Z_DEMO_INCLUDE_GRUPPEI01                .  " PAI-Modules
 INCLUDE Z_DEMO_INCLUDE_GRUPPEF01                .  " FORM-Routines


*SELECTION-SCREEN BEGIN OF SCREEN 1100.
*
*  PARAMETERS:
*    p_artnr  TYPE ZS05_MINIDEMOartikelnummer,
*    p_artgrp TYPE ZS05_MINIDEMO-artikelgruppe,
*    p_vk_b   TYPE ZS05_MINIDEMO-vk_brutto.
*
*SELECTION-SCREEN END OF SCREEN 1100.
*
*AT SELECTION-SCREEN OUTPUT.
*
*  LOOP AT SCREEN.
*
*    CASE sy-tcode.
*
********** transaction für neu preis ausführen*******
*
*      WHEN 'Z_S05_GRDEM1'.
*        IF screen-name = p_artgrp AND screen-name = p_vk_b.
*          screen-active = 0.
*        ENDIF.
*
*        MODIFY SCREEN.


sy-uname










*
*SELECTION-SCREEN BEGIN of SCREEN 1100.
*  PARAMETERS:
*
*  p_artkl type ZGRP03_sweets-artikelnummer.
*
*
*
*SELECTION-SCREEN END OF SCREEN 1100.
*
*at SELECTION-SCREEN output.
*
*if screen
*update ZGRP03_sweets set activeflag = '0'
*where artikelnummer = p_artkl and activeflag = 'X'.
**
**class lcl_events_rb definition.
**  public section.
**
**  class-methods on_radiobutton
**  for event choose_radio_button~rb1
**  of cl_events_selection_screen
**
**  importing rb1.
**
**  endclass.
**
**  class lcl_events_rb implementation.
**    method on_radiobutton.
**
**
**
**      endmethod.
**      endclass.
**
**      start-of-selection.
**
**     PARAMETERS:
**     neu RADIOBUTTON GROUP r1.
**     and RADIOBUTTON GROUP r1.
**     aus RADIOBUTTON GROUP r1.
**     war RADIOBUTTON GROUP r1.
**
**
**
**        DATA: lo_events TYPE REF TO cl_events_selection_screen.
**
**      lo_events = o_salv->get_event( ).
**        set handler lcl_events_rb=>on_radiobutton for lo_events.
*
*
*CLASS lcl_radiobuttons definition abstract.
*  public section.
*  methods: go_to_trx.
*  endclass.
*
*CLASS lcl_radiobuttons implementation.
*
*  method go_to_trx.
*   call transaction 'Z_GRP03_SWEETS' without AUTHORITY-CHECK.
*    endmethod.
*  endclass.
*
*
*   CLASS lcl_rb1 definition INHERITING FROM lcl_radiobuttons.
*  public section.
*  methods go_to_trx redefinition.
*  endclass.
*
*CLASS lcl_rb1 implementation.
*
*  method go_to_trx.
*   super->go_to_trx( ).
*    endmethod.
*  endclass.
*
*
*
*  CLASS lcl_rb2 definition INHERITING FROM lcl_radiobuttons.
*  public section.
*  methods go_to_trx redefinition.
*  endclass.
*
*CLASS lcl_rb2 implementation.
*
*  method go_to_trx.
*   call transaction 'Z_GRP03_SWEETS5' without AUTHORITY-CHECK.
*    endmethod.
*  endclass.
*
*
*    CLASS lcl_rb3 definition INHERITING FROM lcl_radiobuttons.
*  public section.
*  methods go_to_trx redefinition.
*  endclass.
*
*CLASS lcl_rb3 implementation.
*
*  method go_to_trx.
*   call transaction 'Z_GRP03_SWEETS3' without AUTHORITY-CHECK.
*    endmethod.
*  endclass.
*
*
*
*      CLASS lcl_rb4 definition INHERITING FROM lcl_radiobuttons.
*  public section.
*  methods go_to_trx redefinition.
*  endclass.
*
*CLASS lcl_rb4 implementation.
*
*  method go_to_trx.
*   call transaction 'Z_GRP03_SWEETS4' without AUTHORITY-CHECK.
*    endmethod.
*  endclass.
*
*
*  START-OF-SELECTION.
*
*  DATA: lo_rb1 TYPE REF TO lcl_rb1,
*        lo_rb2 TYPE REF TO lcl_rb2,
*        lo_rb3 TYPE REF TO lcl_rb3,
*        lo_rb4 TYPE REF TO lcl_rb4.
*
*
*
*
*  SELECTION-SCREEN END OF BLOCK b1.
*
*  PARAMETERS rb1 RADIOBUTTON GROUP r1.
*  PARAMETERS rb2 RADIOBUTTON GROUP r1.
*  PARAMETERS rb3 RADIOBUTTON GROUP r1.
*  PARAMETERS rb4 RADIOBUTTON GROUP r1.

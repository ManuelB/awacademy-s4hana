*&---------------------------------------------------------------------*
*& Report Z_DEMO_UMLAGERUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_demo_umlagerungc.

tables: zsd_grp2_umlag.
Types : tl type zsd_grp2_umlag.

CLASS lcl_umlagerung DEFINITION.
  PUBLIC SECTION.

  METHODS : fill_umlagerung_tbl
    IMPORTING im_flnr   TYPE tl-filial_nr
              im_arl_nr TYPE tl-artikel_nr
              im_menge  TYPE tl-menge
              im_bwgng  TYPE tl-bewegungsart
              im_flnr1  TYPE tl-filial_nr
              im_men1   TYPE tl-menge
              im_flnr2  TYPE tl-filial_nr
              im_men2   TYPE tl-menge.

ENDCLASS.
CLASS lcl_umlagerung IMPLEMENTATION.

  METHOD fill_umlagerung_tbl.
    DATA ls_umlagerung TYPE zsd_grp2_umlag.
    ls_umlagerung-filial_nr = im_flnr.
    ls_umlagerung-artikel_nr = im_arl_nr.
    ls_umlagerung-menge = im_menge.
    ls_umlagerung-mengeneinheit = 'ST'.
    ls_umlagerung-bewegungsart = im_bwgng.
    IF im_bwgng = '105'.
      ls_umlagerung-soll_haben = '+'.
    ELSE.
      ls_umlagerung-soll_haben = '-'.
    ENDIF.
    ls_umlagerung-verbuchende = sy-uname.
    ls_umlagerung-verbuchungsdatum = sy-datum.
    ls_umlagerung-verbuchungszeit = sy-uzeit.
    INSERT zsd_grp2_umlag FROM ls_umlagerung.
    COMMIT WORK.

    "Werte ausfüllen für 2 Warenbewegung

    ls_umlagerung-filial_nr = im_flnr1.
    IF im_bwgng = '105'. "Bewegungsart = zugang
      ls_umlagerung-bewegungsart = '106'.
      ls_umlagerung-soll_haben = '-'.
    ELSE.
      ls_umlagerung-bewegungsart = '105'.
      ls_umlagerung-soll_haben = '+'.
    ENDIF.
    ls_umlagerung-menge = im_men1.
    INSERT zsd_grp2_umlag FROM ls_umlagerung.
    COMMIT WORK.

*  Werte ausfüllen für 3 Warenbewegung

    IF im_flnr2 IS NOT INITIAL.
      ls_umlagerung-filial_nr = im_flnr2.
      IF im_bwgng = '105'. "Bewegungsart = zugang(inflow)
        ls_umlagerung-bewegungsart = '106'.
        ls_umlagerung-soll_haben = '-'.
      ELSE.
        ls_umlagerung-bewegungsart = '105'.
        ls_umlagerung-soll_haben = '+'.
      ENDIF.
      ls_umlagerung-menge = im_men2.
    ENDIF.
    INSERT zsd_grp2_umlag FROM ls_umlagerung.
    COMMIT WORK.
  ENDMETHOD.
ENDCLASS.
SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  TABLES : zsd_grp2_umlag.
  PARAMETERS:
    p_flnr  TYPE zsd_grp2_umlag-filial_nr OBLIGATORY VALUE CHECK,
    arl_nr  TYPE zsd_grp2_umlag-artikel_nr OBLIGATORY VALUE CHECK,
    p_menge TYPE zsd_grp2_umlag-menge OBLIGATORY,
    p_bwgng TYPE zsd_grp2_umlag-bewegungsart,
    p_flnr1 TYPE zsd_grp2_umlag-filial_nr OBLIGATORY VALUE CHECK,
    p_men1  TYPE zsd_grp2_umlag-menge OBLIGATORY,
    p_flnr2 TYPE zsd_grp2_umlag-filial_nr VALUE CHECK,
    p_men2  TYPE zsd_grp2_umlag-menge.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  DATA lo_umlagerung TYPE REF TO lcl_umlagerung.
  CREATE OBJECT lo_umlagerung.

  lo_umlagerung->fill_umlagerung_tbl(
    EXPORTING
       im_flnr =  p_flnr
      im_arl_nr =  arl_nr
      im_menge =   p_menge
      im_bwgng =   p_bwgng
      im_flnr1 =   p_flnr1
      im_men1  =   p_men1
      im_flnr2 =   p_flnr2
      im_men2  =   p_men2
  ).



*if p_menge NE p_men1+p_men2.


*    CALL METHOD mein_rechteck->set_dimensions
*      EXPORTING
*        im_length  = p_length
*        im_breadth = p_brdth
*      EXCEPTIONS
*        null_value = 1
*        OTHERS     = 2.
*  CASE sy-subrc.
*    WHEN 0.
*      CALL METHOD mein_rechteck->cal_area
*        IMPORTING
*          ex_area = res_area.
*      WRITE :/ 'The area is :', res_area.
*    WHEN 1.
*      WRITE: / 'the dimension cant be 0.' COLOR COL_NEGATIVE..
*    WHEN 2.
*      WRITE 'Some mistake !!'.
*  ENDCASE.

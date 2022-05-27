*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_RECHTECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_rechteck.
*
CLASS rechteck DEFINITION.

  PUBLIC SECTION.
    METHODS :
      constructor
        IMPORTING
*          im_length  TYPE i DEFAULT '4'
*          im_breadth TYPE i DEFAULT '2',
          im_length  TYPE i
          im_breadth TYPE i,
*
      cal_umfang
        IMPORTING  im_length  TYPE i
                   im_breadth TYPE i
*        EXPORTING ex_umfang  TYPE i,   "this is used when get_umfang is not used.
        EXCEPTIONS null_value,

      get_umfang
*        EXPORTING ex_umfang TYPE i,
        RETURNING VALUE(ex_umfang) TYPE i, "when only one parameter has to be given back, returning is used instead of exporting to make the code compact

      cal_area
        EXPORTING ex_area TYPE i,

      set_dimensions
        IMPORTING  im_length  TYPE i
                   im_breadth TYPE i
        EXCEPTIONS null_value.


  PRIVATE SECTION.
    DATA : length  TYPE i,
           breadth TYPE i,
           umfang  TYPE i,
           area    TYPE i.
ENDCLASS.

CLASS rechteck IMPLEMENTATION.

  METHOD constructor.
    length = im_length.
    breadth = im_breadth.
  ENDMETHOD.

  METHOD cal_umfang.
    IF im_length = 0 OR im_breadth = 0.
      RAISE null_value.
    ELSE.
      length = im_length.
      breadth = im_breadth.
      umfang = 2 * ( length + breadth ).
    ENDIF.
*    ex_umfang = umfang.
  ENDMETHOD.

  METHOD get_umfang.
    ex_umfang = umfang.
  ENDMETHOD.

  METHOD set_dimensions.
    IF im_length = 0 OR im_breadth = 0.
      RAISE null_value.
    ELSE.
      length = im_length.
      breadth = im_breadth.
    ENDIF.
  ENDMETHOD.

  METHOD cal_area.
    area = length * breadth.
    ex_area = area.
  ENDMETHOD.

ENDCLASS.
DATA:
*  res_umfang    TYPE i,
  res_area      TYPE i.

PARAMETERS:
  p_length TYPE i,
  p_brdth  TYPE i.

START-OF-SELECTION.
  DATA :
    mein_rechteck TYPE REF TO rechteck.
  CREATE OBJECT mein_rechteck
  EXPORTING
    im_length = p_length
    im_breadth = p_brdth.

  CALL METHOD mein_rechteck->cal_umfang
    EXPORTING
      im_length  = p_length
      im_breadth = p_brdth
*importing ex_umfang = res_umfang. "this statement is used when the method itself is exporting the calculated umfang
*                                    and no get_umfang is used explicitly.
    EXCEPTIONS
      null_value = 1
      OTHERS     = 2.
  CASE sy-subrc.
    WHEN 0.

*  CALL METHOD mein_rechteck->get_umfang
*    IMPORTING
*      ex_umfang = res_umfang.
*           WRITE :/ 'The umfang is :', res_umfang.

*   Methode mit Returning-Parameter:*****************************
*  CALL METHOD mein_rechteck->get_umfang
*    RECEIVING ex_umfang = res_umfang.
*    res_umfang = mein_auto->get_umfang( ).

      WRITE: /5 'returning perimeter value is :', mein_rechteck->get_umfang( ).

    WHEN 1. WRITE: / 'the dimension cant be 0.' COLOR COL_NEGATIVE.
  ENDCASE.


  CALL METHOD mein_rechteck->set_dimensions
    EXPORTING
      im_length  = p_length
      im_breadth = p_brdth
    EXCEPTIONS
      null_value = 1
      OTHERS     = 2.
  CASE sy-subrc.
    WHEN 0.
      CALL METHOD mein_rechteck->cal_area
        IMPORTING
          ex_area = res_area.
      WRITE :/ 'The area is :', res_area.
    WHEN 1.
      WRITE: / 'the dimension cant be 0.' COLOR COL_NEGATIVE..
    WHEN 2.
      WRITE 'Some mistake !!'.
  ENDCASE.

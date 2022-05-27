*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_EXCEPTION_ALKOHOL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_exception_alkohol.

CLASS kaufer_zu_jung DEFINITION
  INHERITING FROM cx_static_check.
  PUBLIC SECTION.
  methods get_text REDEFINITION.
ENDCLASS.
class kaufer_zu_jung IMPLEMENTATION.
  method get_text.
    write :/ 'you are too young to buy alkohol'.
    endmethod.
  ENDCLASS.

CLASS laden DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: alkohol_kaufen
      IMPORTING im_alter TYPE i
* Exception propagieren
      RAISING   kaufer_zu_jung.
ENDCLASS.

CLASS laden IMPLEMENTATION.
  METHOD alkohol_kaufen.
if im_alter > 18.
  write:/ 'Alkohol can be sold'.
* Auslösen der Systemexception cx_sy_zerodivide
  else.
    RAISE EXCEPTION TYPE kaufer_zu_jung.
    endif.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
* Behandlung einer OO-Exception
PARAMETERS : p_alter type i.
data : lo_zujung type ref to kaufer_zu_jung,

      l_laden type ref to laden.
l_laden = new laden( ).
  TRY.
      l_laden->alkohol_kaufen( im_alter = p_alter ).
*    CATCH kaufer_zu_jung INTO DATA(e_text).
*       MESSAGE e_text->get_text( ) TYPE 'S' DISPLAY LIKE 'E'.
      catch kaufer_zu_jung into lo_zujung.
        write:/ lo_zujung->get_text( ).


  ENDTRY.

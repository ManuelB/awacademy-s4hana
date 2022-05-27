*&---------------------------------------------------------------------*
*& Report Z_S05_ASS2AUF10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_ASS2AUF10.

INTERFACE Organisation.
  ENDINTERFACE.

INTERFACE NatuerlichePerson.
  METHODS:
  name RETURNING VALUE(re_name) TYPE string,

  istAngestelltBei
importing organisation TYPE string
  RETURNING VALUE(re_feld) TYPE xfeld.
ENDINTERFACE.

CLASS Praesident DEFINITION.
  PUBLIC SECTION.
  INTERFACES NatuerlichePerson.
  DATA:
        vorname type string,
        nachname type string.
endclass.


CLASS Praesident IMPLEMENTATION.
  METHOD NatuerlichePerson~name.
    re_name = me->nachname.
    endmethod.
  METHOD NatuerlichePerson~istangestelltbei.
    if organisation = 'SWM'.
    re_feld = 'X'.
    elseif organisation NE 'SWM'.
    re_feld = ' '.
    endif.
  endmethod.
endclass.

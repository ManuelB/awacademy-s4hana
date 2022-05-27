*&---------------------------------------------------------------------*
*& Report Z_GRP03_MESSAGE_CLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_GRP03_MESSAGE_CLASS.
CLASS message DEFINITION.
  PUBLIC SECTION.
    METHODS:
      wrong_id,
      pricetoohigh,
      no_id.

  PRIVATE SECTION.

ENDCLASS.

CLASS message IMPLEMENTATION.
  METHOD wrong_id.
    message 'XXX' with p_artkelid.
  ENDMETHOD.
  METHOD pricetoohigh.
    message 'XXX' with p_price.
  ENDMETHOD.
  METHOD no_id.
    message 'XXX' with p_artikelid.
  ENDMETHOD.

ENDCLASS.

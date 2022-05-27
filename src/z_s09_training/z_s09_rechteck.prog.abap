*&---------------------------------------------------------------------*
*& Report Z_S09_RECHTECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S09_RECHTECK.

TYPES: zahl type p length 9 decimals 2.

class Rechteck DEFINITION.

PUBLIC SECTION.
methods:

constructor

IMPORTING

im_zahl1  TYPE zahl

im_zahl2 TYPE zahl,

show_attributes

IMPORTING
  im_rechnen TYPE string,

  rechnen
  IMPORTING
    im_zahl1 TYPE zahl
    im_zahl2 TYPE zahl

    EXPORTING
      ex_u TYPE zahl
      ex_f TYPE zahl
      EXCEPTIONS
        null.

PRIVATE SECTION.
DATA: z1 TYPE zahl,z2 type zahl.

endclass.class Rechteck

IMPLEMENTATION.
method constructor.
  z1 = im_zahl1.
  z2 = im_zahl2.

  endmethod.
  method

*&---------------------------------------------------------------------*
*& Report Z_S05_U37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_U37.

TYPES:
zahl type p length 9 decimals 2.

class Rechteck DEFINITION.

   PUBLIC SECTION. "+
  methods:

* constructor
*        IMPORTING
*           im_zahl1 TYPE zahl
*    im_zahl2 TYPE zahl
*          im_u  TYPE zahl
*         im_f TYPE zahl,
**


   show_attributes,
**
**    set_u
*        IMPORTING ex_u TYPE zahl,
*         set_zahl2
*     IMPORTING ex_f TYPE zahl,
*   get_u
*        RETURNING VALUE(rex_f) TYPE string,
*
*    get_f
*        RETURNING VALUE(rex_u) TYPE string,




  rechnen
  IMPORTING
    im_zahl1 TYPE zahl DEFAULT 5
    im_zahl2 TYPE zahl DEFAUlT 6
 EXPORTING
   ex_u TYPE zahl
   ex_f TYPE zahl
     EXCEPTIONS
    null.

 PRIVATE SECTION.
  DATA:
       z1 TYPE zahl,
       z2 type zahl,
       u type zahl,
       f type zahl.
  endclass.

  class Rechteck IMPLEMENTATION.
*    method constructor.
*      u = im_u.
*      f = im_f.
*     z1 = im_zahl1.
*     z2 = im_zahl2.

*      endmethod.
      method  show_attributes.
*
       WRITE: z1, z2 ,
        / 'U=', u, 'F=', f.
        ENDMETHOD.
        method rechnen.

         z1 = im_zahl1.
          z2 = im_zahl2.
          if im_zahl1 LE 0 or im_zahl2 LE 0.
            RAISE null.
          "  WRITE: 'Das ist eine falsche Eingabe'.
            else.
              u = z1 * z2.
              f = 2 * ( z1 + z2 ).
              endif.

              endmethod.
              endclass.

              PARAMETERS:
 p_zahl1 TYPE zahl,
 p_zahl2 TYPE zahl.

DATA:
      "akt_kz TYPE string,
  d_rechteck TYPE REF TO Rechteck.
           START-OF-SELECTION.
  CREATE OBJECT d_rechteck.

  CALL METHOD d_rechteck->rechnen
    EXPORTING
      im_zahl1 = p_zahl1
     im_zahl2 = p_zahl2
    EXCEPTIONS
      null = 1
      OTHERS  = 2.
  CASE sy-subrc.
    WHEN 0.

      CALL METHOD d_rechteck->show_attributes.
    WHEN 1. WRITE: / 'Fehler; 0' COLOR COL_NEGATIVE.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
  ENDCASE.

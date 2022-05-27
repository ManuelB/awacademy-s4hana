*&---------------------------------------------------------------------*
*& Report ZS04_KLASSE_RECHTECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs04_klasse_rechteck.

CLASS rechteck DEFINITION.

  PUBLIC SECTION.
    METHODS:
*      constructor IMPORTING im_length TYPE i
*                            im_width  TYPE i,

      set_laenge IMPORTING im_length TYPE i,
      set_breite IMPORTING im_width TYPE i,
      rechnen_flaeche IMPORTING im_rechnen TYPE string EXCEPTIONS null,
      rechnen_umfang IMPORTING im_umfang TYPE string EXCEPTIONS null,
      show_result.


  PRIVATE SECTION.
    DATA: length  TYPE i,
          width   TYPE i,
          flaeche TYPE i,
          umfang  TYPE i.

ENDCLASS.


CLASS rechteck IMPLEMENTATION.

  METHOD set_laenge.
    length = im_length.
  ENDMETHOD.

  METHOD set_breite.
    width = im_width.
  ENDMETHOD.

*  METHOD constructor.
*    length = im_length.
*    width = im_width.
*  ENDMETHOD.

  METHOD show_result.
    WRITE: / 'Fläche:', flaeche, 'm2'.
    WRITE: / 'Umfang:', umfang, 'm'.
  ENDMETHOD.

  METHOD rechnen_flaeche.
    IF length EQ 0 OR width EQ 0.
      RAISE null.
    ELSE.
      flaeche = length * width.
    ENDIF.
  ENDMETHOD.

  METHOD rechnen_umfang.
    IF length EQ 0 OR width EQ 0.
      RAISE null.
    ELSE.
      umfang = length + length + width + width.
    ENDIF.
  ENDMETHOD.

ENDCLASS.



SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_laenge TYPE i DEFAULT 17,
              p_width  TYPE i DEFAULT 23.

SELECTION-SCREEN END OF BLOCK a.

DATA rechnen_rechteck TYPE REF TO rechteck.

START-OF-SELECTION.
  CREATE OBJECT rechnen_rechteck.

  CALL METHOD rechnen_rechteck->set_laenge EXPORTING im_length = p_laenge.
  CALL METHOD rechnen_rechteck->set_breite EXPORTING im_width = p_width.
  CALL METHOD rechnen_rechteck->rechnen_flaeche EXPORTING im_rechnen = 'Fläche' EXCEPTIONS null = 1.
  CALL METHOD rechnen_rechteck->rechnen_umfang EXPORTING im_umfang = 'Umfang' EXCEPTIONS null = 1.

  CASE sy-subrc.
    WHEN 1. WRITE: / 'Eingabe von "0" bei Parameter nicht möglich'.
*    WHEN OTHERS. WRITE: / 'Unbekannter Fehler'.
  ENDCASE.

  CALL METHOD rechnen_rechteck->show_result.

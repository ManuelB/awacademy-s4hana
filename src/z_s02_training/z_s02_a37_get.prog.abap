*&---------------------------------------------------------------------*
*& Report Z_S02_A37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_a37_get.

CLASS rechteck DEFINITION.
  PUBLIC SECTION.
    METHODS:
      umfang
        IMPORTING
          i_L TYPE i
          i_B TYPE i
        EXCEPTIONS
          null,
      flaeche
        IMPORTING
          i_L TYPE i
          i_B TYPE i
        EXCEPTIONS
          null,
      show_attributes.
  PRIVATE SECTION.
    DATA:
      rflaeche TYPE i,
      rumfang  TYPE i.
ENDCLASS.




CLASS rechteck IMPLEMENTATION.
    METHOD show_attributes.
    WRITE: / 'Umfang', rumfang, 'Fläche:', rflaeche.
    endmethod.
  METHOD umfang.
    IF i_L EQ 0.
      RAISE null.
    ELSEIF i_B EQ 0.
      RAISE null.
    ELSE.
      rumfang = 2 * i_L + 2 * i_b.
    ENDIF.
  ENDMETHOD.
  METHOD flaeche.
    IF i_L EQ 0.
      RAISE null.
    ELSEIF i_B EQ 0.
      RAISE null.
    ELSE.
      rflaeche = i_L * i_b.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


***** Hauptprogramm
PARAMETERS:
  p_laenge TYPE i DEFAULT 5,
  p_breite TYPE i DEFAULT 3.

DATA:
      mein_rechteck TYPE REF TO rechteck.

START-OF-SELECTION.
  CREATE OBJECT mein_rechteck.


  CALL METHOD mein_rechteck->umfang
    EXPORTING
      i_L    = p_laenge
      i_B    = p_breite
    EXCEPTIONS
      null   = 3
      OTHERS = 99.
  CASE sy-subrc.
    WHEN 0. CALL METHOD mein_rechteck->show_attributes.
    WHEN 3. WRITE: / 'Null eingegeben'.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
  ENDCASE.

  CALL METHOD mein_rechteck->flaeche
    EXPORTING
      i_L    = p_laenge
      i_B    = p_breite
    EXCEPTIONS
      null   = 3
      OTHERS = 99.
  CASE sy-subrc.
    WHEN 0. CALL METHOD mein_rechteck->show_attributes.
    WHEN 3. WRITE: / 'Null eingegeben'.
    WHEN OTHERS. WRITE: / 'irgendein Fehler'.
  ENDCASE.

*&---------------------------------------------------------------------*
*& Report ZS01_A37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_a37.
PARAMETERS: p_length TYPE kkek_dec3,
            p_width  TYPE kkek_dec3.

CLASS rechteck DEFINITION.
  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          im_length TYPE kkek_dec3
          im_width  TYPE kkek_dec3,
      calculation,
      show_result.



  PRIVATE SECTION.

    DATA area TYPE kkek_dec3.
    DATA volume TYPE kkek_dec3.
    DATA length TYPE kkek_dec3.
    DATA width TYPE kkek_dec3.

ENDCLASS.

CLASS rechteck IMPLEMENTATION.
  METHOD constructor.
    length = im_length.
    width = im_width.
  ENDMETHOD.

  METHOD calculation.

    area = length * width.
    volume = ( 2 * length ) + ( 2 * width ).

  ENDMETHOD.

  METHOD show_result.
    WRITE: / area.
    WRITE: / volume.

  ENDMETHOD.

ENDCLASS.

DATA rechteck1 TYPE REF TO rechteck.

START-OF-SELECTION.

  CREATE OBJECT rechteck1
    EXPORTING
      im_length = p_length
      im_width  = p_width.

  CALL METHOD rechteck1->calculation.
  CALL METHOD rechteck1->show_result.



*Aufgabe A37: Rechteck
*• Schreiben Sie eine lokale Klasse „Rechteck“ mit jeweils einer Methode für die
*Berechnung des Umfangs und der Fläche eines Rechtecks. Länge und Breite sollen
*eingegeben werden können und während der Instantiierung mittels des Konstruktors
*übergeben werden. Die berechneten Werte sollen ausgegeben werden.
*• Ist einer der beiden Eingabewerte gleich 0, so soll während der Berechnung eine
*Ausnahme ausgelöst und geeignet behandelt werden.
*• Schreiben Sie ein ABAP-Programm, welches ermöglicht, zur Laufzeit Eingabewerte
*für ein Rechteck einzugeben und welches die Ergebnisse bzw. die Ausnahmen
*ausgibt.

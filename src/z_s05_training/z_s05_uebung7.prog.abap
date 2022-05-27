*&---------------------------------------------------------------------*
*& Report Z_S05_UEBUNG7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s05_uebung7.

TYPES:
  summe   TYPE p LENGTH 8 DECIMALS 3,
  rechnen TYPE c LENGTH 1,
  text TYPE c length 15.

DATA:
  rech1 TYPE summe,
  rech2 TYPE summe,
  operation1 type text,
  operation2 type text,
  typ1 type text,
  typ2 type text.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE Berch1.

  PARAMETERS:
    a1       TYPE summe DEFAULT 15,
    b1       TYPE summe DEFAULT 7,
    rechner1 TYPE rechnen DEFAULT 'U'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE Berech2.

  PARAMETERS:

    a2       TYPE summe DEFAULT 5,
    b2       TYPE summe DEFAULT 5,
    rechner2 TYPE rechnen DEFAULT 'F'.


SELECTION-SCREEN END OF BLOCK b2.

IF a1 LE 0 OR a2 LE 0 OR b1 LE 0 OR b2 LE 0.
  WRITE: 'Fehler! 0 oder weniger ist nicht Erlaubt.'.
  return.

ELSE.


  PERFORM rechteck USING a1 b1 rechner1 CHANGING rech1 operation1 typ1.
  PERFORM rechteck USING a2 b2 rechner2 CHANGING rech2 operation2 typ2.

ENDIF.

WRITE: / 'Berechnung 1' COLOR COL_GROUP,
/ |Länge = { a1 } cm|,
/ |Breite = { b1 } cm|.
ULINE.
WRITE: |{ operation1 } = { rech1 } cm | COLOR COL_KEY,
/ |Das ist ein: { typ1 } | .

ULINE.
ULINE.

WRITE: / 'Berechnung 2' COLOR COL_GROUP,
/ |Länge = { a2 } cm|,
/ |Breite = { b2 } cm|.
ULINE.
WRITE: |{ operation2 } = { rech2 } cm| COLOR COL_KEY,
/ |Das ist ein: { typ2 } | .



form rechteck USING a b rechner CHANGING rech operation typ.
  case rechner.
    when 'U'.
      rech = a * b.
      operation = 'Umfang'.
      if a = b.
        typ = 'Quadrat'.
        else.
          typ = 'Rechteck'.
          endif.

              when 'F'.
      rech = 2 * ( a + b ).
      operation = 'Flache'.
      if a = b.
        typ = 'Quadrat'.
        else.
          typ = 'Rechteck'.
          endif.
          when others.
            WRITE: 'Falsches Operation'.
            endcase.

endform.

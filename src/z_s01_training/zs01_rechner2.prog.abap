*&---------------------------------------------------------------------*
*& Report Z_S01_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_case.

*Verstanden.

PARAMETERS p_zahl_1 TYPE p DEFAULT 5.
PARAMETERS p_op(1)  TYPE c.
PARAMETERS p_zahl_2 TYPE p DEFAULT 17.

*Siehe hier: man kann mit Parameter direkt rechnen.

DATA lv_ergebnis(5) TYPE p DECIMALS 2. " Decimals nicht vergessen!
* Contains Any: Wahr, wenn P_op eines der Zeichen hat.
IF p_op CA '+-*/'.

ELSE.
*  Unten taucht eine Message mit den angebenen Text auf. Type S ist eine inplementierte Fehlermeldung ohne hartem Ende. E ist mit hartem Ende.
*  Display Like E, weil S- Message die Eigenschaften von einer E message haben soll.

  MESSAGE 'Bitte geben sie einen validen Rechenoperator an.' TYPE 'S' DISPLAY LIKE 'E'.
  RETURN. "Ablauflogik wird wieder beendet
ENDIF.

*Case
CASE p_op.
  WHEN '+'.
    WRITE:/ 'ADDITION'.
    lv_ergebnis = p_zahl_1 + p_zahl_2.

  WHEN '-'.
    WRITE:/ 'SUBTRAKTION'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.

  WHEN '*'.
    WRITE:/ 'MULTIPLIKATION'.
    lv_ergebnis = p_zahl_1 * p_zahl_2.

  WHEN '/'.
*    Hier wieder if Bedingung, um 0 auszuwerten.
    IF p_zahl_2 = 0.
      WRITE: / 'Fehler: Division durch 0 nicht möglich'.
      Exit.
    ELSE.
      WRITE:/ 'DIVISION'.
      lv_ergebnis = p_zahl_1 / p_zahl_2.
    ENDIF.
*Der exception case für case
  WHEN OTHERS.
    WRITE: 'FEHLER'.
ENDCASE.

* Hier einfach nur auflistung von den obigen eingaben. Siehe, wie alles durch KOmma getrennt ist und Text auch rein kann.
WRITE: / | { p_zahl_1 }  { p_op } { p_zahl_2 } = { lv_ergebnis } |. "Ergebnis durch 0 geteilt wird als 0 gezeigt.

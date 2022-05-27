*&---------------------------------------------------------------------*
*& Report Z_S01_RECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs01_rechner.

*Varianten
*
*
*Verstanden.

* p = datentyp für DezimalZahlen.
DATA lv_zahl TYPE p DECIMALS 2.
DATA lv_ergebnis TYPE p DECIMALS 2.



*Führt zuerst alles bis zu Start-of-Selection aus.
INITIALIZATION.


*1. Frame Start. Wichtig müssen benannt werden.
  SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME.
*2. Frame start.
    SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
*Textfelder
      PARAMETERS p_zahl_1 LIKE lv_zahl. " parameter übernimt Eigenschaften von Variable.
      PARAMETERS p_zahl_2 LIKE lv_zahl.
*Ende 1. frames
    SELECTION-SCREEN END OF BLOCK b1.
*Start 3. Frame
    SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
*Multiplce choice buttons einer Gruppe.
      PARAMETERS p_add RADIOBUTTON GROUP r1.
      PARAMETERS p_sub RADIOBUTTON GROUP r1 DEFAULT 'X'.
      PARAMETERS p_mult RADIOBUTTON GROUP r1.
      PARAMETERS p_div RADIOBUTTON GROUP r1.
* Ende 3. und 1 frame.
    SELECTION-SCREEN END OF BLOCK b2.
  SELECTION-SCREEN END OF BLOCK b0.
*IfBedingungen
*Wenn addition ausgewählt

  p_zahl_1 = 1.  "Diesen zusammenhang nochmal anschauen.

START-OF-SELECTION.
* Wenn beides nicht da wäre, dann würde er erst den unteren Teil ausführen.


  IF p_add = abap_true. " Addition | ABAP_TRUE ist eine Konstante für 'X'. false dann ' '
    WRITE: / 'Addition!'.
    lv_ergebnis = p_zahl_1 + p_zahl_2.

  ELSEIF p_sub = 'X'.
    WRITE: / 'Subtraktion!'.
    lv_ergebnis = p_zahl_1 - p_zahl_2.

  ELSEIF p_mult = 'X'.
    WRITE: / 'Multiplikation!'.

    lv_ergebnis = p_zahl_1 * p_zahl_2.

  ELSEIF p_div = 'X'.
    WRITE: / 'Division!'.
*  Hier eine if-Else -Bedingung in der ElseIF-Bedingung.
    IF p_zahl_2 = 0.
      WRITE: 'Fehler! Division durch 0 nicht zulässig!'.
      Exit. " Im Hauptrogramm abbrechen
    ELSE.
      lv_ergebnis = p_zahl_1 / p_zahl_2.
    ENDIF.
  ELSE.
    WRITE: / 'Fehler! Keine korrekte Verrechnugsoperation gewählt'.
  ENDIF.

*Prüft ob Ergebniswert da ist. Wenn sich Ergebniswert von Initialwerrt unterscheidet, dann ausgabe. Soll Testen, ob user etwas eingegeben hat.
  IF lv_ergebnis IS NOT INITIAL.
    WRITE: / lv_ergebnis.
  ELSE.
    WRITE: / 'Fehler: Ergebnismenge leer!'.
  ENDIF.

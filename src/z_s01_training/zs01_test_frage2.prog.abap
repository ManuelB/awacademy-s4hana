*&---------------------------------------------------------------------*
*& Report ZS01_AUFGABE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS01_FRAGE2.

Schreiben Sie ein ABAP-Programm, das folgende Anforderungen erfüllt:
Die folgende FORM-Routine soll als Funktionsbaustein umprogrammiert werden. Ziel des Unterprogramms ist,
einen Währungsbetrag in eine andere Währung umzurechnen.

FORM convert_currency
  USING source_amount, source_curr, target_curr, target_factor
  CHANGING target_amount.
  Target_amount = source_curr * target_factor.
ENDFORM.

Dabei sollen source_amount, target_amount mit dem Datenelement DEC5_2,
target_factor mit TCURR-FACTOR
 und source_curr sowie target_curr mit CHAR03 typisiert werden.

Schreiben Sie die Lösung wie folgt in den Quiz-Editor:
Schnittstelle: Im Stil von „Formalparameter: Parametertyp, Name, Datentyp“, für alle Parameter

Funktionsbaustein-Name: ZS01_CONVERT_CURRENCY

Schnittstelle:
IMPORTING:
source_amount TYPE DEC5_2
source_curr TYPE CHAR03
target_factor TYPE TCURR-FACTOR
target_curr TYPE  TYPE CHAR03

Exporting, weil changing macht kein Sinn, weil ich Target amount erst überhaupt hier einen wert hat.
EXPORTING
target_amount type DEC5_2

Quellcode


FUNCTION.

  *Target_amount = source_curr * target_factor.

 ENDFUNCTION.

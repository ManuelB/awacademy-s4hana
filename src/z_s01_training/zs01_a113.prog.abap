REPORT z_s01_test_rechner.

*Funktionsgruppe: Znn_TR
*Funktionsbausteine: Znn_rechnen, Znn_ausgabe

*Übung T11-3: Taschenrechner mit FunktionsbausteinX
*Kopieren Sie Ihr Programm aus Übung T11-3 und schreiben es wie folgt um:X
*Beide FORM-Routinen werden durch eigene Funktionsbausteine ersetzt.X
*Fangen Sie dabei die eventuell auftretenden Ausnahmen über EXCEPTIONS ab.

*Datentypen: Sie können zur Vereinfachung mit simplen Typen arbeiten (Typ I bzw. C ohne
*Längenangabe).
*Verwendung von Typen aus einem Type-Pool: nutzen Sie die vom Trainer zur Verfügung gestellten
*Typen des im Seminar kommunizierten Type-Pools.
*Testen Sie Ihren Baustein über die Testumgebung des Function Builders.
*Nutzen Sie für den Einbau in Ihrem ABAP-Report die Muster-Funktion.

PARAMETERS P_1zahl TYPE zrk02_ty_betrag.
PARAMETERS P_op TYPE zrk02_ty_operator.
PARAMETERS P_2zahl TYPE zrk02_ty_betrag.
DATA lv_result TYPE zrk02_ty_betrag.



CALL FUNCTION 'ZS01_RECHNEN'
  EXPORTING
    f_op           = p_op
    f_1zahl        = p_1zahl
    f_2zahl        = p_2zahl

  IMPORTING
    f_lv_result    = lv_result
  EXCEPTIONS
    zero_divide    = 1
    wrong_operator = 2
    OTHERS         = 3.

CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS01_AUSGABE'.
  WHEN 1. WRITE: / 'Nulldivision nicht möglich'.
  WHEN 2. WRITE: / 'Falscher Operator'.
  WHEN 3. WRITE: / 'Ein unbekannter Fehler'.

 ENDCASE.


CALL FUNCTION 'ZS01_AUSGABE'
  IMPORTING
    f_1zahl      = p_1zahl
    f_2zahl      = p_2zahl
    f_op         = p_op
    f_lv_result1 = lv_result.

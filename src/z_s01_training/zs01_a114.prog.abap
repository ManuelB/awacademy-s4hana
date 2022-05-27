REPORT z_s01_test_rechner.

*Funktionsgruppe: Znn_TR
*Funktionsbausteine: Znn_rechnen, Znn_ausgabe

*Übung T11-4: Taschenrechner mit FORM und Dictionary-Typen
*Kopieren Sie Ihr Programm aus Übung T11-3 und schreiben es wie folgt um:
*Alle Datentypen sollen aus dem Dictionary kommen und über Datenelemente realisiert werden.

*Wenn sinnvoll möglich, nutzen Sie nicht nur die Werthilfe für den Operator, sondern fangen auch
*darüber eventuelle Fehleingaben beim Operator ab.

*Erweitern Sie die Berechnung um die Funktion „Quadratwurzel“ (Operator: r bzw. R) und Prozent
*(Operator: p bzw. P), die wie folgt wirken soll:
*bei Quadratwurzel wird nur die erste Zahl als Argument genommen.
*Bei Prozent rechnen Sie das Verhältnis der ersten zur zweiten Zahl in Prozent um.

*Ist es möglich, diese zusätzlichen Operatoren beim verwendeten Datenelement in die Werthilfe, d.h.
*in die Festwerte der zugehörigen Domäne, aufzunehmen? – Falls ja, dann machen Sie das!

*Suchen + Finden: Nutzen Sie dabei den Verwendungsnachweis, indem Sie zuerst nach geeigneten
*Domänen suchen und dann dazu passende Datenelemente.
*Nutzen Sie beim Suchen die erweiterte Suche („alle Selektionen“ ankreuzen


SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME.

  PARAMETERS P_1zahl TYPE operand_value.
  PARAMETERS P_op TYPE foperator.
  PARAMETERS P_2zahl TYPE operand_value.
  DATA lv_result TYPE operand_value.


SELECTION-SCREEN END OF BLOCK a.


CALL FUNCTION 'ZS01_RECHNEN'
  EXPORTING
    f_op              = p_op
    f_1zahl           = p_1zahl
    f_2zahl           = p_2zahl
  IMPORTING
    f_lv_result       = lv_result
  EXCEPTIONS
    zero_divide       = 1
    wrong_operator    = 2
    negative_argument = 3
    OTHERS            = 4.
CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS01_AUSGABE'.
  WHEN 1. WRITE: / 'Nulldivision nicht möglich'.
  WHEN 2. WRITE: / 'Falscher Operator'.
  WHEN 3. WRITE: / 'Wurzel aus negativer Zahl nicht möglich'.
  WHEN 4. WRITE: / 'Irgendein anderer Fehler'.

ENDCASE.


CALL FUNCTION 'ZS01_AUSGABE'
  IMPORTING
    f_1zahl      = p_1zahl
    f_2zahl      = p_2zahl
    f_op         = p_op
    f_lv_result1 = lv_result.



*Funktionsbausteine anlegen.
*Funktionsgruppe anlegen
*Dann Funktionsbaustein dort anlegen und aktivieren.
*über Schreibzwinge f8 kannst du die Funktionsbausteine TEsten.
*
*Programm>prüfen>*Erweiterte Programmprüfung
*
*Using Value, changing = Wertübergabe.
*Using = Referenzübergabe.
*SELECT-OPTIONS herumspielen und benutzen. Sehr nützliches Werkzeug.

*Text immer auf  English schreiben.

*Überschriften der Parameter Ändern:

*Springen<Textelemente

*Überschrift de sProgramms ändern.
*Programm ausführen < System y listen < Listenüberschrift

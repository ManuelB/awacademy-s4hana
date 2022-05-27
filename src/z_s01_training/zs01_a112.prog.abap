REPORT z_s01_test_rechner.




*Übung T11-2: Taschenrechner mit FORM
*Kopieren Sie Ihr Programm aus Übung T11-1 und schreiben es wie folgt um:
*Die Berechnung soll als FORM-Routine gekapselt werden. Die Ausgabe ebenfalls. Wie und welche
*Variablen sollten über Parameter übergeben werden?

PARAMETERS P_1zahl TYPE p DECIMALS 2 DEFAULT 0.
PARAMETERS P_op(1) TYPE c.
PARAMETERS P_2zahl TYPE p DECIMALS 2 DEFAULT 0.
DATA lv_result TYPE p DECIMALS 2.


PERFORM rechnen USING p_1zahl p_2zahl p_op CHANGING lv_result.

PERFORM ausgabe USING p_1zahl p_2zahl p_op lv_result.



FORM rechnen USING p_1zahl p_2zahl p_op CHANGING lv_result.
CASE p_op.
  WHEN ' '.
    MESSAGE 'Es wurde kein Operator eingegeben.' TYPE 'S' DISPLAY LIKE 'E'.

  WHEN '+'.
    lv_result = p_1zahl + p_2zahl.

  WHEN '-'.
    lv_result = p_1zahl - p_2zahl.

  WHEN '*'.
    lv_result = p_1zahl * p_2zahl.

  WHEN '/'.
    IF p_2zahl <> 0.
      lv_result = p_1zahl / p_2zahl.
    ELSE.

      MESSAGE 'Es kann nicht durch 0 geteilt werden.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

  WHEN OTHERS.
    MESSAGE 'Der Operator ist unbekannt.' TYPE 'S' DISPLAY LIKE 'E'.

ENDCASE.

ENDFORM.



FORM ausgabe USING p_1zahl p_2zahl p_op lv_result.

WRITE:/ |  { p_1zahl } |.
WRITE:/ |  { p_2zahl } |.
WRITE:/ |  { p_op } |.
ULINE.
WRITE:/ |  { lv_result } |.

ENDFORM.

REPORT z_s01_test_rechner.

*Namenskonventionen
*Die folgenden Konventionen sind ein Vorschlag für die Teilnehmer, aber nicht verpflichtend. Ob die
*Programme als lokales Objekt gespeichert oder einem eigenen Paket zugeordnet werden, ist
*fakultativ.
*Programme:
*Znn_uebxx,
*nn = Ihre zweistellige Ziffernfolge aus der SAP-ID,
*xx = Übungsnummer ohne Sonderzeichen
*Funktionsgruppe: Znn_TR
*Funktionsbausteine: Znn_rechnen, Znn_ausgabe

*Taschenrechner
*Übung T11-1: Taschenrechner
*Schreiben Sie ein ABAP-Programm, mit dem man die 4 Grundrechenarten ausführen kann.
*Es sollen dabei auf dem Eingabebild die beiden Zahlen sowie der Rechen-Operator eingegeben
*werden können.
*Auf der Ausgabeliste soll ein aussagekräftiges „Protokoll“ der Berechnung dargestellt werden.
*Fangen Sie eventuelle Fehleingaben mit einfachen Mitteln ab.

PARAMETERS P_1zahl TYPE p DECIMALS 2 DEFAULT 0.
PARAMETERS P_op(1) TYPE c.
PARAMETERS P_2zahl TYPE p DECIMALS 2 DEFAULT 0.
DATA lv_result TYPE p DECIMALS 2.

*Fehler = x * 0 =



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
    Exit.
    ENDIF.

  WHEN OTHERS.
    MESSAGE 'Der Operator ist unbekannt.' TYPE 'S' DISPLAY LIKE 'E'.

ENDCASE.


  WRITE:/ |  { p_1zahl } |.
  WRITE:/ |  { p_2zahl } |.
  WRITE:/ |  { p_op } |.
  ULINE.
  WRITE:/ |  { lv_result } |.

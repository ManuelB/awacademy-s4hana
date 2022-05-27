*&---------------------------------------------------------------------*
*& Report Z_S01_WDH_Z3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_wdh_z3.


*verstanden.

*Hier wenn Zeit da Ist, Fehler korrigieren.
*Mit ID stimmt irgendwas nicht. Siehe Debugger. Erstes Feld.
BREAK-POINT.
*Strukturentyp wird erstellt.
* TYPE i typisiert nicht die Strutktur, sondern den von der Struktur unabhängigen lokalen Typen lty_num
TYPES: lty_wdh3,
       BEGIN OF lty_s_auto3,
         Model(20) TYPE c,
         Marke(20) TYPE c,
         baujahr   TYPE c,

       END OF lty_S_Auto3

       .
*Deklaration & Typisiereung der Tabelle & Struktur.

DATA ls_auto3 TYPE lty_s_auto3.

*SORTED = gibt sortierte Tabellenart an (Gegensatz: STANDARD TABLE).
*WITH UNIQUE KEY = Inhalt soll anhand des Primärschlüsselwerts sortiert werden. UNIQUE = Zwei gleiche werte können nicht eingefügt werden.

DATA lt_auto3 TYPE SORTED TABLE OF lty_s_auto3 WITH NON-UNIQUE KEY baujahr.

*Mit It
ls_auto3-baujahr = |ID1991|.
ls_auto3-marke = |VW|.
ls_auto3-model = |Golf|.

APPEND ls_auto3 TO lt_auto3.

ls_auto3-baujahr = |ID1944|.
ls_auto3-marke = |Bla|.
ls_auto3-model = |Egal|.


APPEND ls_auto3 TO lt_auto3.

ls_auto3-baujahr = |ID2015|.
ls_auto3-marke = |BMW|.
ls_auto3-model = |X2|.


APPEND ls_auto3 TO lt_auto3.

ls_auto3-baujahr = |ID2010|.
ls_auto3-marke = |Toyota|.
ls_auto3-model = |Corola|.

APPEND ls_auto3 TO lt_auto3.

CLEAR ls_auto3.  "Damit alle alten Daten weg sind.

*Neuen Nutzer Hinzufügen, überprüfen, ob es den schon gibt. Wenn Baujahr schon vergeben, nächstes vorschlagen, das nicht vergeben ist.

ls_auto3-baujahr = |ID2012|.
ls_auto3-marke = |BMW2|.
ls_auto3-model = |X2-3|.

*TRANSPORTING NO FIELDS überprüft mit READ TABLE, ob die Zeile vorhanden ist. füllt auch die Systemfelder sy-subrc sowie sy-tabix.
READ TABLE lt_auto3 WITH TABLE KEY baujahr = ls_auto3 TRANSPORTING NO FIELDS. "Nichts zu transportieren.

IF sy-subrc = 0.
  WRITE:/ | Baujahr schon vorhanden |.

ELSE.
  WRITE:/ | Baujahr noch nicht vorhanden.|.
ENDIF.


*Variante der Abfrage des Baujahrs über einen LooP
DATA lv_zeilenanzahl TYPE i. "Zur SPeicherung der Zeilenanzahl.
DATA: lv_max_id_c(6) TYPE n. "Zum Teilen der des Baujahres. Für den 2. Teil.
DATA: dummy TYPE String. " Zum Teilen der des Baujahres. Für den 1. Teil



*DATA: lv_max_id_c(6) TYPE n. "n numerisches Textfeld.
*DATA dummy TYPE string.


* Wenn es eine passende Zeile in der Tabelle zur  Where Bedingung gibt, liest er sie in die Struktur.
LOOP AT lt_auto3 INTO ls_auto3 WHERE baujahr = ls_auto3-baujahr.
ENDLOOP.

IF sy-subrc <> 0.
  APPEND ls_auto3 TO lt_auto3.
ELSE.
  WRITE: / | Baujahr { ls_auto3-baujahr }  schon vergeben |.

  MESSAGE: | Baujahr { ls_auto3-baujahr }  schon vergeben | TYPE 'S' DISPLAY LIKE 'E'.

*Lines = bestimmt aktuelle Anzahl der Tabellenzeilen der internen Tabelle. Braucht lv_zeilenanzahl, um die Info zu speichern.
*Describe Table bittet um Info über die Tabelle.
  DESCRIBE TABLE lt_auto3 LINES lv_zeilenanzahl. " Wird die letzt Zeile sein, weil er alle Zeilen zählt.

*  Liest die Tabelle, sucht nach Index lv_zeilenanzahl, überträgt dann diese Zeile in ls_auto3.
  READ TABLE lt_auto3 INDEX lv_zeilenanzahl INTO ls_auto3.

  SPLIT ls_auto3-baujahr AT 'ID' INTO dummy lv_max_id_c. "Spaltet Baujahr in 2 seperate variablen.
  lv_max_id_c = lv_max_id_c + 1 . "Erhöht den letzten Teil des Baujahres um 1.

  ls_auto3-baujahr = | Jahr + 1: { lv_max_id_c } |.

  WRITE: / | Das nächste freie Baujahr wäre: { ls_auto3-baujahr }|.

ENDIF.

BREAK-POINT.


*Wenn du dir im Debugger anschaust welcher Wert in der Struktur im Feld baujahr steht,
*oder wie die erste Zeile aussieht, die in deine lokale tabelle geschrieben wird, sollte dir auffallen, dass da etwas mit deiner ID nicht stimmt..

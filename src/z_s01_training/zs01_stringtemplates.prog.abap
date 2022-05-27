*&---------------------------------------------------------------------*
*& Report Z_S01_STRING_TEMPLATES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_string_templates.
*Ähnliche Funktion wie Anführungszeichen

* verstanden

DATA: lv_ausgabetext TYPE String,
      lv_text(50)    TYPE c VALUE 'Text',
      lv_zahl        TYPE i.



lv_zahl = 5.
lv_ausgabetext = |Variableninhalt|.

WRITE: / | Dies ist ein Text.|.

ULINE.

*Leerzeichen wichtig in der klammer. Der Inhalt der Variable in der Klamme wird ausgedrückt.
WRITE: / | Dies ist ein Text. { lv_ausgabetext }|.
WRITE: / | Dies ist ein Text. { lv_zahl }|.

ULINE.
*alte Variante
WRITE: / 'testtext', lv_zahl.
*Bessere Variante. Diese Nutzen. '-' wichtig, sonst Leerstellen. Spart Zeit, weil du damit keinn Concatinate brauchst.
WRITE: / |Testtext- { lv_zahl }|.

WRITE: / | Hier { lv_zahl  ALIGN = RIGHT WIDTH = 100 }|. " Rechtsbündig.

ULINE.

WRITE: / sy-datlo. "Ein Systemfeld. Sind implementierte befehle, die Systemzustände abfragen
WRITE: / | { sy-datlo DATE = RAW }|.
WRITE: /  | Raw: { sy-datlo DATE = ISO }|.
WRITE: / | { sy-datlo DATE = USER }|.

ULINE.
"Raw, ISO, User. Verschiedene Formatierungsmöglichkeiten.
WRITE: / sy-uzeit.
WRITE: / | { sy-uzeit TIME = RAW }|.
WRITE: / | { sy-uzeit TIME = ISO }|.
WRITE: / | { sy-uzeit TIME = USER }|.

ULINE.

*timestampl vorgefertigtes Objekt aus dem dictionary.
DATA lv_timestamp TYPE timestampl. "Hinter Type die Domäne. Auch objekt aus ddic,schon existierend.
GET TIME STAMP FIELD lv_timestamp. " Befehl für systemfeld timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|."iso nur, damit das vernünftig lesbar ist."

WAIT UP TO 2 SECONDS.
GET TIME STAMP FIELD lv_timestamp.
WRITE: / |Timestamp: { lv_timestamp TIMESTAMP = ISO }|.

*&---------------------------------------------------------------------*
*& Report Z_S02_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s02_write.

WRITE 'hello world'.

"Kettensatz oder sowas"

WRITE: 'HELLO WORLD'.

WRITE: /, 'hello world'.

WRITE: 'Servus', 'Erde'.


"Variable einfügen"
"Variable ist ein Container, der verschiedene Werte annehmen kann"
"Befehl dazu DATA"
"Es muss ein Typ angegeben werden. STRG+Leerzeichen"

DATA lv_hello TYPE string VALUE 'HALLIHALLO'.

"lv Prefix steht für Lokale Variable"

DATA lv_penis TYPE string VALUE 'PENIS'.

"Strg+D" kopiert Zeile"
"ULINE. macht Zeile"

ULINE.

WRITE: lv_hello, lv_penis.

"mit F1 Hilfe"


DATA lv_testausgabe(10) TYPE c VALUE 'Bon'.

"für Typ c muss man eine Länge mitangeben, sonst ist Länge 1"
"Typ c =beliebige alphanumerische Zeichen"
"Beliebige alphanumerische Zeichen; gültige Werte sind aber nur die Ziffern 0 bis 9"

ULINE.

WRITE: lv_testausgabe, lv_penis.

*&---------------------------------------------------------------------*
*& Report Z_S01_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_write.

*Hier alles verständlich.

WRITE: 'Hello', 'World 1'.

WRITE: / 'Hello'.
WRITE: / 'World 2'.

DATA Textausgabe TYPE string VALUE 'Hello World 3'. "So werden Variablen deklariert.präfix vor namen ist üblich: lv_"
DATA Textausgabe2(25) TYPE c VALUE  'Hello World 10'. "Bei C muss man die characteranzahl eingeben."

ULINE.

WRITE: Textausgabe, Textausgabe.

"strg + D = Zeile kopieren"
"Vorschlagshilfe = strg + Leer"
"F1 = Dokumentation"


DATA: a TYPE i VALUE 3,
       b TYPE i VALUE 7.


WRITE: |{ sy-datlo DATE = RAW }|.

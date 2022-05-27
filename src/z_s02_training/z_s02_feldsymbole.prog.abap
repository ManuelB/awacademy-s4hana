*&---------------------------------------------------------------------*
*& Report Z_S02_FELDSYMBOLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_FELDSYMBOLE.

"Werden immer in solchen Klammern geschrieben.
" Ist ein Zeiger, der immer auf einen Variable, Struktur oder Tabelle zeigt.

"<Beispielfeldsymbol>

DATA lv_Zahl TYPE i.


"Deklaration des Feldsymboles <zahl>:

FIELD-SYMBOLS <zahl> TYPE i.

"Zuordnug des Speicherbereichs der Variablen lv_Zahl zum Feld-Symbol <zahl>.

ASSIGN lv_zahl TO <zahl>.


" Wenn man dem Feldsymbol einen anderen Wert gibt, dann wird er auch in der Variable übernommen, weil das Feldsymbol keinen eigenen Speicher hat.
<zahl> = 17.


*********


TYPES: BEGIN OF lty_user,
         id        TYPE i,
         vname(15) TYPE c,
         nname(15) TYPE c,
       END OF lty_user.


DATA ls_user TYPE lty_user.
DATA lt_user TYPE TABLE OF lty_user.

FIELD-SYMBOLS <user> TYPE lty_user.

ls_user-id    = 1.
ls_user-vname = 'Paul'.
ls_user-nname = 'Fischer'.
APPEND ls_user TO lt_user.

ls_user-id    = 2.
ls_user-vname = 'Mickey'.
ls_user-nname = 'Mouse'.
APPEND ls_user TO lt_user.



LOOP AT lt_user ASSIGNING <user>.  "es wird automatisch die Zeile assigned. man spart sich MODIFY und READ TABLE
  <user>-nname = 'Rosch'.
ENDLOOP.

" man weist während eines Loops einer Zelle einen neuen Wert zu, was so voll easy geht
" Es ist möglich, während eines Loops der aktuellen Zeile der Tabelle ein Feldsymbol zuzuordnen
" Damit können die Daten der Zeile direkt verändert werden.
" In diesem Beispiel nennt der Loop den Fischer und den Mouse in Rosch um.


*****

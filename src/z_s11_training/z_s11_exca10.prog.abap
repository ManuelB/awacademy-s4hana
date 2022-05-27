*&---------------------------------------------------------------------*
*& Report Z_S11_EXCA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_EXCA10.

*Data : t_rechteck type p length 5 decimals 3.
Types : begin of t_rechteck,
  length type p length 5 decimals 3,
width type p length 5 decimals 3,
  end of t_rechteck.

  Data: rechteck type t_rechteck.

PARAMETERS : p_length type p length 5 decimals 3,
p_width type p length 5 decimals 3.

*data :
*      length type t_rechteck,
*      breadth type t_rechteck

rechteck-length = p_length.
rechteck-width = p_width.

Data : umfang type p length 5 decimals 3,
 area type p length 5 decimals 3.

Perform cal using rechteck changing umfang area.
write :/ 'The perimeter is :', umfang, 'The area is :', area.

*
form cal using rechteck1 type t_rechteck changing umfang1 area1.

  umfang1 = 2 * ( rechteck1-length + rechteck1-width ).
  area1 = rechteck1-length * rechteck1-width.


  endform.



*
*  Schreiben Sie ein ABAP Programm, dass Berechnungen an einem Rechteck vornimmt.
*Länge und Breite des Rechtecks sollen dabei über eine Eingabemaske festlegbar sein.
*Für  die  Speicherung  der  Eingabewerte  soll  ein  komplexer  Typ  „t_rechteck“  definiert
*werden,  der  die  beiden  Komponenten  „laenge“  und  „breite“  enthält.  Nach  Eingabe  der
*Länge und Breite sollen die Fläche und der Umfang des Rechtecks berechnet werden;
*außerdem soll bestimmt werden, ob es sich bei dem Rechteck um ein Quadrat handelt.
*Die  Berechnungen  sollen  dabei  jeweils  als  eine  Form-Routine  implementiert  werden,
*welche als Parameter eine Variable des von Ihnen definierten Typs „t_rechteck“
*entgegennimmt. Die Ergebnisse der  Berechnungen sollen in geeigneter Weise auf dem
*Bildschirm  ausgegeben  werden.  Sollten  Angaben  fehlen,  so  treffen  Sie  geeignete
*Annahmen.

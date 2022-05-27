*&---------------------------------------------------------------------*
*& Report Z_S03_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S03_FELDSYMBOLE_AUFGABE.

INCLUDE Z_T04_I_FLUGDATEN.

*DATA lt_spfli TYPE TABLE OF spfli.



FIELD-SYMBOLS <spfli> TYPE spfli.




LOOP AT lt_spfli ASSIGNING <spfli> where cityfrom = |FRANKFURT| or cityto = |FRANKFURT|.
  IF <spfli>-cityfrom = |FRANKFURT|.
  <spfli>-cityfrom = |DÜSSELDORF|.
  ELSEIF <spfli>-cityto = |FRANKFURT|.
  <spfli>-cityto = |DÜSSELDORF|.

*ELSEIF <spfli>-cityfrom ne |FRANKFURT|.
*  MESSAGE: | Keine Änderung beim Flug für { <spfli>-connid }| TYPE 'S'.
*  ELSEIF <spfli>-cityto ne |FRANKFURT|.
*  MESSAGE: | Keine Änderung beim Flug für { <spfli>-connid }| TYPE 'S'.
* CORRECTION : juste ELSE. MESSAGE.
  ENDIF.
WRITE: / |Connid: { <spfli>-connid }  jetzt geändert von { <spfli>-cityfrom } nach { <spfli>-cityto } |.
   ENDLOOP.



* Avec les Feldsymbole, on peut agir directement sur le tableau et changer les données dedans
*   quand on loope. pas besoin de ls lokale Struktur.

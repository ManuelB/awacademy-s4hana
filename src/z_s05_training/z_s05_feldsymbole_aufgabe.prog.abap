*&---------------------------------------------------------------------*
*& Report Z_S05_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_FELDSYMBOLE_AUFGABE.

*Aufgabe: Implementiere das INCLUDE ... mit denn bereits mit den dir bereits bekannten Fldaten aus dem SAP Flugendatenmodell.
* In der Lokalen Tabelle SPFLI sollen alle Verbindungen die nach Frankfurt kommen auf Düsseldorf umgeleitet werde.
*Daten in der itab ändern


INCLUDE z_t04_i_flugdaten.
TABLES spfli.
DATA ls_spfli    TYPE spfli   . "Deklaration einer lokalen Struktur anhand der Datenbanktabelle SPFLI
DATA ls_scarr    TYPE scarr   .



FIELD-SYMBOLS <flight> TYPE spfli.

"<flightfrom> = 'Düsseldorf'.
"<flightto> = 'Düsseldorf'.

SELECT-OPTIONS so_sfl FOR ls_spfli-connid DEFAULT 0400 NO INTERVALS.




 LOOP AT lt_spfli ASSIGNING <flight> WHERE cityfrom EQ 'FRANKFURT' OR cityto EQ 'FRANKFURT'
  AND connid IN so_sfl.



   IF <flight>-cityfrom EQ 'FRANKFURT'.
     <flight>-cityfrom = 'DÜSSELDORF'.
     <flight>-airpfrom = 'DUS'.





     ELSEIF <flight>-cityto EQ 'FRANKFURT'.
     <flight>-cityto = 'DÜSSELDORF'.
     <flight>-airpto = 'DUS'.






     ELSE.
       MESSAGE: |'Fehler!'| TYPE 'e'.

       ENDIF.


   ENDLOOP.

   LOOP AT lt_spfli ASSIGNING <flight> WHERE connid IN so_sfl.

     FORMAT COLOR OFF.
     IF  <flight>-airpto = 'DUS' or <flight>-airpfrom = 'DUS'.
       FORMAT COLOR 4.
       ENDIF.
     WRITE: / |{ spfli-connid } { <flight>-cityfrom } { <flight>-airpfrom }|.

EXIT.
     ENDLOOP.

   BREAK-POINT.

*&---------------------------------------------------------------------*
*& Report Z_S12_FELDSYMBOLE_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_feldsymbole_aufgabe.
*"Feldsymbol --> Zeiger welcher immer auf den Speicherbereich eines bestimmten Datenobjektes zeigt
*"Dieses Datenobjekt kann eine Variable, Tabelle, Textbereich etc. sein
**<BeispielFeldsymbol>
*
*data lv_zahl type i.
*FIELD-SYMBOLS <zahl> type i. "Deklaration des Feldsymbols <zahl>
*
*lv_zahl = 23.
*"Zuordnung des Feldsymbols zum Speicherbereich der Variable
*assign lv_zahl to <zahl>. "lokale Variable dem Feldsymbol zu ordnen
*
*<zahl> = 17.
*
*
*
*************************************************************************************************************************
*TYPES: BEGIN OF lty_user,
*         id        TYPE i,
*         vname(15) TYPE c,
*         nname(15) TYPE c,
*       END OF lty_user
*       .
*
*DATA ls_user TYPE lty_user.
*DATA lt_user TYPE TABLE OF lty_user.
*
*FIELD-SYMBOLS <user> type lty_user.
*
*ls_user-id    = 1.
*ls_user-vname = |Paul|.
*ls_user-nname = |Fischer|.
*APPEND ls_user TO lt_user.
*
*ls_user-id    = 2.
*ls_user-vname = |Max|.
*ls_user-nname = |Mustermann|.
*APPEND ls_user TO lt_user.
*
*"Es ist möglich während eines Loops der aktuellen Zeile der Tabelle ein Feldsymbol zuzuordnen
*"Damit können die Daten der Zeile direkt verändert werden
*loop at lt_user ASSIGNING <user>. "Assignement erfolg hier und nicht seperat
*  <user>-nname = |Konstanz|.
*
*  ENDLOOP.
*
*BREAK-POINT.
**************************************************************************************************************
INCLUDE z_t04_i_flugdaten.

*TYPES: BEGIN OF lty_umleitung,
*cityfrom(20) TYPE c,
*cityto(20) TYPE c,
*connid TYPE i,
*airpfrom(3) TYPE c,
*airpto(3) TYPE c,
**  connid(4) type n,
*END of lty_umleitung.

*data lt_umleitung type lty_umleitung.

*DATA lt_spfli   TYPE TABLE OF spfli.
FIELD-SYMBOLS <fluege> TYPE spfli.


*LOOP AT lt_spfli assigning <fluege> WHERE cityto EQ |FRANKFURT| and cityfrom eq |FRANKFURT|.
*
*    <fluege>-cityto = |Duesseldorf|.
*    <fluege>-cityfrom = |Duesseldorf|.
*    <fluege>-airpfrom = |DUS|.
*    <fluege>-airpto = |DUS|.
*    uline.
*    Write: / |Fluege werden von Frankfurt nach Duesseldorf umgeleitet!|.
*     WRITE: /  |From: { <fluege>-cityfrom } To: { <fluege>-cityto }|.
*
*ENDLOOP.

LOOP AT lt_spfli ASSIGNING <fluege>.

  IF <fluege>-cityto EQ |FRANKFURT|.
    <fluege>-cityto = |DÜSSELDORF|.
    <fluege>-airpto = |DUS|.
        WRITE: /  |Connid: { <fluege>-connid } geändert. Jetzt von { <fluege>-cityfrom } nach { <fluege>-cityto }|.
  ELSEIF   <fluege>-cityfrom EQ |FRANKFURT|.
    <fluege>-cityfrom = |DÜSSELDORF|.
    <fluege>-airpfrom = |DUS|.
      WRITE: /  |Connid: { <fluege>-connid } geändert. Jetzt nach { <fluege>-cityto } von { <fluege>-cityfrom }|.
*  ELSE.
*    WRITE: / |No flights from or to Frankfurt!|.
  ENDIF.

ENDLOOP.

*LOOP AT lt_spfli ASSIGNING <fluege> WHERE cityfrom = |FRANKFURT| or cityto = |FRANKFURT| .
*    <fluege>-cityto = |Duesseldorf|.
*    <fluege>-airpto = |DUS|.
*    <fluege>-cityfrom = |Duesseldorf|.
*    <fluege>-airpfrom = |DUS|.
*    WRITE: /  |Connid: { <fluege>-connid } geändert. Jetzt von { <fluege>-cityfrom } nach { <fluege>-cityto }|.
*
*
*
*ENDLOOP.

BREAK-POINT.

*******************************************************************************************************************************
*Lösung von Robin

*Aufgabe: Implentiere das INCLUDE z_t04_i_flugdaten mit den dir bereits bekannten Flugdaten aus dem SAP Flugdatenmodell.
*         In der Lokalen Tabelle SPFLI sollen alle Verbindungen, die nach Frankfurt gehen und von Frankfurt kommen auf Düsseldorf umgeleitet werden.
*         Ändere die Daten in der internen Tabelle.
*         Gib die neuen Verbindungen aus.

INCLUDE z_t04_i_flugdaten.
*DATA lt_spfli   TYPE TABLE OF spfli.

*FIELD-SYMBOLS <spfli> TYPE spfli.

LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<spfli>) WHERE cityfrom EQ 'FRANKFURT' OR cityto EQ 'FRANKFURT'. " Inline Deklaration von <spfli>
  IF <spfli>-cityfrom EQ 'FRANKFURT'.
    <spfli>-cityfrom = 'DÜSSELDORF'.
    <spfli>-airpfrom = 'DUS'.

  ELSEIF <spfli>-cityto EQ 'FRANKFURT'.
    <spfli>-cityto = 'DÜSSELDORF'.
    <spfli>-airpto = 'DUS'.

  ELSE.
    MESSAGE:|Es wurden unerwartete Daten selektiert. FROM:{ <spfli>-cityfrom } TO:{ <spfli>-cityto }| TYPE 'E'.

  ENDIF.

ENDLOOP.

*Gesonderte Formatierung der geänderten Zeilen
LOOP AT lt_spfli ASSIGNING <spfli>.
  FORMAT COLOR off.
  IF <spfli>-airpfrom EQ 'DUS' OR <spfli>-airpto EQ 'DUS'.
    FORMAT COLOR 6. "Färbt geänderte Zeilen rot ein
  ENDIF.
  WRITE: / |ConnID:{ <spfli>-connid } From:{ <spfli>-cityfrom } TO:{ <spfli>-cityto }|.
ENDLOOP.

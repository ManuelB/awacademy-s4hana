*&---------------------------------------------------------------------*
*& Report ZBC401_LOCALEVENTS
*&---------------------------------------------------------------------*
REPORT z_s11_zbc401_localevents.

* Definition der Daten und lokalen Klassen/Methoden
INCLUDE Z_S11_LOCALEVENTSDATA.
*INCLUDE zbc401_localeventsdata.

* Implementierung der lokalen Klassen/Methoden
* Code für die geforderte Funktionaltät
INCLUDE Z_S11_LOCALEVENTSIMPL.
*INCLUDE zbc401_localeventsimpl.

* Selektion Fluggesellschaft, Mindeszahl freie Plätze
SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_carrid TYPE sflight-carrid,
              p_seats  TYPE i OBLIGATORY.
SELECTION-SCREEN END OF BLOCK a.

START-OF-SELECTION.

*1. Instanziieren: 3 Varianten
*CREATE OBJECT my_oref. // new ...
*(aufpassen wegen Übergabe der Constructor-Parameter)
*Kettensatzlogik:
*CREATE OBJECT:
*   oref1,
*   oref2,
*   oref3.
*(aufpassen: geht auch mit Parametern)

*---------------Objekt erzeugen mit Referenz auf die lokale Klasse
* - 1
*  DATA(o_ref) = NEW lcl_seatsocc( p_carrid ).

* - 2
*  DATA o_ref TYPE REF TO lcl_seatsocc.
*  CREATE OBJECT o_evt
*    EXPORTING
*      carrid = p_carrid.

*- 3
  DATA: o_ref1 TYPE REF TO lcl_seatsocc.
*        o_ref2 TYPE REF TO lcl_seatsocc,
*        o_ref3 TYPE REF TO lcl_seatsocc.

  CREATE OBJECT:
   o_ref1
    EXPORTING
      carrid = p_carrid.
*    o_ref2
*    EXPORTING
*      carrid = p_carrid,
*       o_ref3
*    EXPORTING
*      carrid = p_carrid .

* Handler registrieren: Zuordnung von Eventhandler "on_my_event" zu Objekt der Klasse mit Eventtrigger für my_event
  SET HANDLER lcl_eventhandler=>on_my_event FOR ALL INSTANCES. "FOR o_ref1.

* Berechnung der verfügbaren Sitzplätze
  freeseats = o_ref1->chk_seats( ).

* Auslösen des Events wenn verfügbare Pläte kleiner Mindestzahl aus Selektion
  IF freeseats LT p_seats.
    o_ref1->raise_event( freeseats ).
  ENDIF.

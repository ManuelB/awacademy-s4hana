*&---------------------------------------------------------------------*
*& Report ZBC_INTERFACE_RFC_NT_TABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zs11_interface_rfc_nt_table.

DATA: lv_max_rows TYPE soid-accnt VALUE '100'.       " auf 100 Einträge begrenzen, 0 - alle
DATA: lv_separator TYPE char1 VALUE ';'.             " Spaltenseparator
DATA: it_rfc_stxh TYPE STANDARD TABLE OF char512.    " RFC-Datentabelle, Spaltensumme max 512 Zeichen, da Rückgabetyp Zeile -> TAB512
" das Problem kann man "umgehen", indem man die Spalten einzeln einliest (Performance!)
DATA: it_fields TYPE STANDARD TABLE OF rfc_db_fld.   " Namen der Spalten
DATA: it_options TYPE STANDARD TABLE OF rfc_db_opt.  " 72 Zeichen
DATA: it_stxh TYPE STANDARD TABLE OF stxh.           " umgewandelte Ausgabetabelle mit richtigen DDIC-Datentypen
DATA: it_split_values TYPE STANDARD TABLE OF string. " Splitzeile für Datenkonvertierung

* Spalten
it_fields = VALUE #( ( fieldname = 'TDOBJECT' )
                     ( fieldname = 'TDNAME' )
                     ( fieldname = 'TDID' )
                     ( fieldname = 'TDTITLE' )
                     ( fieldname = 'TDLUSER' ) ).

* WHERE-Bedingung
it_options = VALUE #( ( |TDOBJECT EQ 'TEXT' AND TDID EQ 'ADRS'| ) ).

* Daten per RFC aus Fremdsystem holen, Userlogin wird abgefragt
* und Berechtigng S_TABU_DIS
* Nachteil: es sind nur einfache Tabellenabfragen möglich, keine JOINS
CALL FUNCTION 'RFC_READ_TABLE' DESTINATION 'NONE' "'XA1'
  EXPORTING
    query_table           = 'STXH'
    delimiter             = lv_separator
    rowcount              = lv_max_rows
  TABLES
    options               = it_options
    fields                = it_fields   " Aufruf: Liste der zu lesenden Felder, Rückgabe: Zu jedem Feld Offset, Länge, Typ, Kurztext
    data                  = it_rfc_stxh
  EXCEPTIONS
    table_not_available   = 1
    table_without_data    = 2
    option_not_valid      = 3
    field_not_valid       = 4
    not_authorized        = 5
    data_buffer_exceeded  = 6
    system_failure        = 7
    communication_failure = 8
    OTHERS                = 9.

IF sy-subrc = 0.
  TRY .
* Datenausgabe
      LOOP AT it_rfc_stxh ASSIGNING FIELD-SYMBOL(<rfc_stxh_line>).

* neue Zeile in der Ausgabetabelle erzeugen
        APPEND INITIAL LINE TO it_stxh ASSIGNING FIELD-SYMBOL(<stxh>).
* Elemente der Datenzeile am Separator splitten
        SPLIT <rfc_stxh_line> AT lv_separator INTO TABLE it_split_values.
* Elemente ausgeben
        LOOP AT it_split_values ASSIGNING FIELD-SYMBOL(<value>).
* Spalte + Zelle der Ausgabetabelle anhand des Spaltennamens holen
* es werden nur Werte die Spalten gefüllt, die in it_fields deklariert wurden
          ASSIGN COMPONENT it_fields[ sy-tabix ]-fieldname OF STRUCTURE <stxh> TO FIELD-SYMBOL(<cell>).
          IF <cell> IS ASSIGNED.
* Split-Wert in die Zelle schreiben
            <cell> = condense( val = <value> ).
          ENDIF.

        ENDLOOP.
      ENDLOOP.

* Ausgabe
* Header
      DATA(lv_head) = ||.

      LOOP AT it_fields ASSIGNING FIELD-SYMBOL(<field>).
        DATA(lv_sl) = strlen( <field>-fieldname ).
        DATA(lv_width) = COND i( WHEN lv_sl < <field>-length THEN lv_sl ELSE <field>-length ).
        lv_head = |{ lv_head }{ substring( val = <field>-fieldname off = 0 len = lv_width ) WIDTH = <field>-length + 1 }|.
      ENDLOOP.

      WRITE: / lv_head.

* Daten
      LOOP AT it_stxh ASSIGNING FIELD-SYMBOL(<line>).
        WRITE: / <line>-tdobject, <line>-tdname, <line>-tdid, <line>-tdtitle, <line>-tdluser.
      ENDLOOP.

    CATCH cx_root INTO DATA(e_text).
      WRITE: / e_text->get_text( ).
  ENDTRY.
ELSE.
  WRITE: / 'Fehler:', sy-subrc.
ENDIF.

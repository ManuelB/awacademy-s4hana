*&---------------------------------------------------------------------*
*& Report Z_S01_WDH_Z6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s01_wdh_z6.

*verstanden.

*Select data
SELECT *
  INTO TABLE @DATA(it_spfli) " kopiert daten von SPFLI in interne Tabelle.
  FROM spfli.

*loop & group examples
*Feldsymbol ist ein Zeiger, der auf eine Zeile einer Tabelle zeigt. Braucht deshalb keinen Speicher.
*LOOP AT it_spfli ASSIGNING FIELD-SYMBOL(<c>)
*  GROUP BY <c>-carrid ASCENDING. "Fasst Mehrere Einträge von Zeilen (in Diesem Fall Carrid zu einem Eintrag zusammen)
*
*  WRITE: | { <c>-carrid }, { <c>-connid }|.
*
*  LOOP AT GROUP <c> ASSIGNING FIELD-SYMBOL(<p>). "Macht ein FeldSymbol auf die oben beschriebene Gruppe. Gibt jeden einzelnen Eintrag aus der Gruppe aus.
*    WRITE: / ' ', <p>-carrid, <p>-connid,<p>-cityfrom, <p>-cityto.
*
*  ENDLOOP.
*  ULINE.
*
*ENDLOOP.



*
*LOOP AT it_spfli ASSIGNING FIELD-SYMBOL(<c>)
*  GROUP BY ( carrid = <c>-carrid
*  size = GROUP SIZE " Gibt größe der Gruppe aus
*  index = GROUP INDEX " Gibt index der Zeile aus
*  )
*  ASCENDING
**  WITHOUT MEMBERS " sagt, dass der Inhalt der Gruppen nicht benötigt wird.
*  REFERENCE INTO DATA(o_carrid) "Was geschieht hier?
*  .
*Write: / | { o_carrid->carrid } { o_carrid->size } { o_carrid->index } |.
*
*LOOP AT group o_carrid ASSIGNING FIELD-SYMBOL(<p>).
*  write: / <p>-carrid, <p>-airpfrom, <p>-airpto.
*
*ENDLOOP.
*
*
*ENDLOOP.

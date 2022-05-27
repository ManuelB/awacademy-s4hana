*&---------------------------------------------------------------------*
*& Report Z_S12_SQL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_sql.

*data carrid type spfli-carrid.
*cl_demo_input=>request( CHANGING field = carrid ).
*
*data: begin of result,
*  carrid type sflight-carrid,
*  connid type sflight-connid,
*  end of result.
*  select carrid, connid
*    from sflight
*    into CORRESPONDING FIELDS OF @result "- @DATA(result_new) -
*    where carrid = @carrid.
*    ...
*    ENDSELECT.
*
*    FIELD-SYMBOLS <result> like result.
*    select carrid, connid
*      from sflight
*      into CORRESPONDING FIELDS OF @<result>
*      where carrid = @carrid.
*      ...
*      ENDSELECT.
""""""""""""""""""""""""""""""""""""""""""""""""""""Kopie von spfli mit Daten befüllen""""""""""""""""""""""""""""""""""""""""""""""""""""
SELECT * INTO TABLE @DATA(tspfli) "Selektiert alle Einträge aus spfli und schreibt diese in die neue interne standard Tabelle tspfli
  FROM spfli.

INSERT ZAWS12_spfli FROM TABLE tspfli. "schreib alle Einträge aus tspfli in meine leere Kopie der spfli
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.

""""""""""""""""""""""""""""""""""""""""""""""""""""Kopie von sbook mit Daten befüllen""""""""""""""""""""""""""""""""""""""""""""""""""""
SELECT * INTO TABLE @DATA(tsbook)
    FROM sbook.
INSERT ZAWS12_scarr FROM TABLE tscarr.
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.

""""""""""""""""""""""""""""""""""""""""""""""""""""Kopie von scarr mit Daten befüllen""""""""""""""""""""""""""""""""""""""""""""""""""""
SELECT * INTO TABLE @DATA(tscarr)
   FROM scarr.
INSERT ZAWS12_sbook FROM TABLE tsbook.
IF sy-subrc = 0. "Wenn Daten vorhanden --> Ausführen
  COMMIT WORK.
ENDIF.

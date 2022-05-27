*&---------------------------------------------------------------------*
*& Report ZAW_S04_TRANSFERDATA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaws04_sql_transferdata.


**********************************************************************
"Tabelleninhalte von SPFLI in eigene Kopie ZAWS04_SPFLI kopieren.

*SELECT * INTO TABLE @DATA(lt_spfli) FROM spfli.
*
*INSERT zaws04_spfli FROM TABLE lt_spfli.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.



**********************************************************************
"Tabelleninhalte von SFLIGHT in eigene Kopie ZAWS04_SFLIGHT kopieren.

*SELECT * INTO TABLE @DATA(lt_sflight) FROM sflight.
*
*INSERT zaws04_sflight FROM TABLE lt_sflight.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.



**********************************************************************
"Tabelleninhalte von SCARR in eigene Kopie ZAWS04_SCARR kopieren.

*SELECT * INTO TABLE @DATA(lt_scarr) FROM scarr.
*
*INSERT zaws04_scarr FROM TABLE lt_scarr.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.



***********************************************************************
*"Tabelleninhalte von SBOOK in eigene Kopie ZAWS04_SBOOK kopieren.
*
*SELECT * INTO TABLE @DATA(lt_sbook) FROM sbook.
*
*INSERT zaws04_sbook FROM TABLE lt_sbook.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.
*
*
*
***********************************************************************
*"Tabelleninhalte von SCUSTOM in eigene Kopie ZAWS04_SCUSTOM kopieren.
*
*SELECT * INTO TABLE @DATA(lt_scustom) FROM scustom.
*
*INSERT zaws04_scustom FROM TABLE lt_scustom.
*
*IF sy-subrc = 0.
*  COMMIT WORK.
*ENDIF.

*&---------------------------------------------------------------------*
*& Report Z_S09_AUFGABE_RAINER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s09_aufgabe_rainer.



SELECT * INTO TABLE @DATA(tspfli)
 FROM spfli.

MODIFY ZS09_SPFLI FROM TABLE tspfli.

IF sy-subrc = 0.
  COMMIT WORK.
ENDIF.

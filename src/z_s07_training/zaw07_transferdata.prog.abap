*&---------------------------------------------------------------------*
*& Report ZAW07_TRANSFERDATA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAW07_TRANSFERDATA.

SELECT * into TABLE @DATA(tspfli)
  from spfli.

  insert zs07_spfli from table tspfli.

  if sy-subrc = 0.
    commit WORK.
    ENDIF.

    SELECT * into TABLE @DATA(tsflight)
  from sflight.

  insert zs07_sflight from table tsflight.

  if sy-subrc = 0.
    commit WORK.
    ENDIF.
BREAK-POINT.

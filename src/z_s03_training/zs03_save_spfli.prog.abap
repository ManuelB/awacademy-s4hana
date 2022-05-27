*&---------------------------------------------------------------------*
*& Report ZS03_SAVE_SPFLI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS03_SAVE_SPFLI.

select * INTO TABLE @DATA(tspfli)
FROM spfli.

MODIFY ZS03_SPFLI FROM TABLE tspfli.

if sy-subrc = 0.
COMMIT WORK.
ENDIF.

select * INTO TABLE @DATA(tscarr)
FROM scarr.

MODIFY ZS03_SCARR FROM TABLE tscarr.

if sy-subrc = 0.
COMMIT WORK.
ENDIF.

select * INTO TABLE @DATA(tsbook)
FROM sbook.

MODIFY ZS03_SBOOK FROM TABLE tsbook.

if sy-subrc = 0.
COMMIT WORK.
ENDIF.


select * INTO TABLE @DATA(tsflight)
FROM sflight.

MODIFY ZS03_SFLIGHT FROM TABLE tsflight.

if sy-subrc = 0.
COMMIT WORK.
ENDIF.

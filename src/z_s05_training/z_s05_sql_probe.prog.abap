*&---------------------------------------------------------------------*
*& Report Z_S05_SQL_PROBE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_PROBE.


select * into TABLE @data(tscustom)
  FROM scustom.

 modify zs05_scustom FROM TABLE tscustom.

  IF sy-subrc = 0.
    commit work.
    endif.


    select * into TABLE @data(tsbook)
  FROM sbook.

 modify zs05_sbook FROM TABLE tsbook.

  IF sy-subrc = 0.
    commit work.
    endif.


       DATA:
  customid TYPE zS05_scustom-id VALUE 1.

cl_demo_input=>new(
  )->add_field( CHANGING field = customid )->request( ).

SELECT c~carrid, c~fldate, p~id, p~name, p~city, f~cityfrom, f~cityto
       FROM ( ( zS05_spfli AS f




         INNER JOIN zS05_sbook AS c ON c~carrid = f~carrid

             INNER JOIN zS05_scustom AS p ON p~id   = c~customid
                              AND p~id = @customid ) )



       ORDER BY c~fldate DESCENDING, p~name, f~cityfrom

       INTO TABLE @DATA(itab2).

          cl_demo_output=>display( itab2 ).

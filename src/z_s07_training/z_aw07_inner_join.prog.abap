*&---------------------------------------------------------------------*
*& Report Z_AW07_INNER_JOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_INNER_JOIN.



*SELECT c~carrname, p~connid, f~fldate
*       FROM ( ( scarr AS c
*         INNER JOIN spfli AS p ON p~carrid   = c~carrid
*                              AND p~cityfrom = @p_cityfr
*                              AND p~cityto   = @p_cityto )
*         INNER JOIN sflight AS f ON f~carrid = p~carrid
*                                AND f~connid = p~connid )
*       INTO CORRESPONDING FIELDS OF TABLE @itab.
*
*cl_demo_output=>display( itab ).


DATA:
  carrid TYPE spfli-carrid VALUE 'LH',
  cityto TYPE spfli-cityto   VALUE 'HAMBURG'.

cl_demo_input=>new(
  )->add_field( CHANGING field = carrid
  )->add_field( CHANGING field = cityto )->request( ).

SELECT  p~connid, f~fldate, price
       FROM ( ( scarr AS c
         INNER JOIN spfli AS p ON p~carrid   = @carrid
                              AND p~cityto = @cityto )
         INNER JOIN sflight AS f ON f~connid = p~connid )
       ORDER BY c~carrname, p~connid, f~fldate
       INTO TABLE @DATA(itab2).

  cl_demo_output=>display( ITAB2 ).

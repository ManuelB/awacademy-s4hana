*&---------------------------------------------------------------------*
*& Report Z_S02_SQL_INNERJOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_SQL_INNERJOIN.

*DATA:
*  cityfr TYPE spfli-cityfrom VALUE 'FRANKFURT',
*  cityto TYPE spfli-cityto   VALUE 'OSAKA'.
*
*cl_demo_input=>new(
*  )->add_field( CHANGING field = cityfr
*  )->add_field( CHANGING field = cityto )->request( ).
*
*SELECT c~carrname, p~connid, f~fldate
*       FROM ( ( scarr AS c
*         INNER JOIN spfli AS p ON p~carrid   = c~carrid
*                              AND p~cityfrom = @cityfr
*                              AND p~cityto   = @cityto )
*         INNER JOIN sflight AS f ON f~carrid = p~carrid
*                                AND f~connid = p~connid )
*       ORDER BY c~carrname, p~connid, f~fldate
*       INTO TABLE @DATA(itab).
*  cl_demo_output=>display( ITAB ).

*******

DATA:
  cityfr TYPE spfli-cityfrom VALUE 'FRANKFURT',
  cityto TYPE spfli-cityto   VALUE 'OSAKA'.

cl_demo_input=>new(
  )->add_field( CHANGING field = cityfr
  )->add_field( CHANGING field = cityto )->request( ).

SELECT c~carrname, p~connid, f~fldate
       FROM ( ( scarr AS c " c steht für scarr, p für spfli, f für sflight
         INNER JOIN spfli AS p ON p~carrid   = c~carrid " das = ist das Joinen
                              AND p~cityfrom = @cityfr " hier sind selektionskriterien
                              AND p~cityto   = @cityto ) " hier sind selektionskriterien
         INNER JOIN sflight AS f ON f~carrid = p~carrid
                                AND f~connid = p~connid )
       ORDER BY c~carrname, p~connid, f~fldate
       INTO TABLE @DATA(itab). " itab steht für interne Tabelle, ist aber ein willkürlicher Name
  cl_demo_output=>display( ITAB ).

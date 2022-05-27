*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_INNERJOIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_abapsql_innerjoin.

*DATA:
*  cityfr TYPE zs06spfli-cityfrom VALUE 'FRANKFURT',
*  cityto TYPE zs06spfli-cityto   VALUE 'OSAKA'.
*
*
*SELECT c~carrname, p~connid, f~fldate
*       FROM ( ( scarr AS c
*
*
*         INNER JOIN zs06spfli AS p ON p~carrid   = c~carrid
*                              AND p~cityfrom = @cityfr
*                              AND p~cityto   = @cityto )
*
*
*         INNER JOIN zs06sflight AS f ON f~carrid = p~carrid
*                                AND f~connid = p~connid )
*
*
*       ORDER BY c~carrname, p~connid, f~fldate
*
*       INTO TABLE @DATA(itab).
*
*       cl_demo_output=>display( itab ).


SELECT "command to select below named fields (the a,b,etc. is just a given reference for the tables where these fiels are to be found in
  a~Currency, "the currency field from sflight
  b~carrname, "the carriername from scarr
  b~url "the urld from scarr

  from zs06sflight AS a "here the reference A is given
  INNER JOIN zs06scarr AS b" here the reference B is given
  ON a~carrid = b~carrid "here is declared which field in both tables (they have to be the same) are used to join (index or key field)


  INTO TABLE @DATA(result).

cl_demo_output=>display( Result ).

"add more qearies here.

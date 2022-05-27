*&---------------------------------------------------------------------*
*& Report ZA_S05_SQL_COALESCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_COALESCE.

CONSTANTS: co_no_email TYPE ad_smtpadr VALUE '<leer>'.
*constants are working like DATA but only for reading, changes are not possible
*TYPE --like data type of the field
*VALUE <leer> can be almost anything

SELECT u~bname,
  u~persnumber,
  u~addrnumber,
  COALESCE( a~smtp_addr, @co_no_email ) AS email
  INTO TABLE @DATA(it_usr)
  FROM usr21 AS u
 LEFT OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber AND a~addrnumber = u~addrnumber.


    cl_demo_output=>display( it_usr ).

*&---------------------------------------------------------------------*
*& Report Z_S11_SQL_COALESCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_SQL_COALESCE.

CONSTANTS : co_no_email TYPE ad_smtpadr VALUE '<leer>'.

SELECT u~bname, u~persnumber, u~addrnumber,
  COALESCE( a~smtp_addr, @co_no_email ) as email
  into table @DATA(it_user)
  FROM usr21 AS u
  left OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber and a~addrnumber = u~addrnumber.

  cl_demo_output=>display( it_user ).



*SELECT u~bname, u~persnumber, u~addrnumber, a~smtp_addr
*  into table @DATA(it_user)
*  FROM usr21 AS u
*  left OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber and a~addrnumber = u~addrnumber.
*
*  cl_demo_output=>display( it_user ).

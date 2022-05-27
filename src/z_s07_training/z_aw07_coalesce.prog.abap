*&---------------------------------------------------------------------*
*& Report Z_AW07_COALESCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AW07_COALESCE.

*Null-Werte (Nicht vorhandene Email-Adressen), die sich aus dem LEFT OUTER JOIN ergeben,
*werden durch den String'<leer>' ersetzt.


CONSTANTS: co_no_email TYPE ad_smtpadr VALUE '<leer>'.
SELECT u~bname,
  u~persnumber,
  u~addrnumber,
  COALESCE( a~smtp_addr, @co_no_email ) AS email
  INTO TABLE @DATA(it_usr)
  FROM usr21 AS u
  LEFT OUTER JOIN adr6 AS a ON a~persnumber = u~persnumber and a~addrnumber =
  u~addrnumber.

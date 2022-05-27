*&---------------------------------------------------------------------*
*& Report Z_S11_EXCA12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_exca12.

*Es soll aus der R/3-Tabelle SCARR gelesen werden. Geben Sie für alle
*Fluggesellschaften  die  Felder  CARRID,  CARRNAME  und  URL  aus.  Die  Ausgabe  soll
*sortiert nach der CARRID dargestellt werden.

SELECT carrid, carrname, url
  FROM scarr
  ORDER BY carrid DESCENDING
  INTO TABLE @DATA(lt_scarr).


cl_demo_output=>display( lt_scarr ).

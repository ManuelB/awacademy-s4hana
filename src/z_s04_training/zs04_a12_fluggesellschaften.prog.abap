*&---------------------------------------------------------------------*
*& Report ZS04_A12_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZS04_A12_FLUGGESELLSCHAFTEN.

SELECT FROM scarr
  FIELDS carrid, carrname, url
  ORDER BY carrid
  INTO TABLE @DATA(ausgabe).


    cl_demo_output=>display( ausgabe ).

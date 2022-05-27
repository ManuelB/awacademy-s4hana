*&---------------------------------------------------------------------*
*& Report Z_S05_SQL_PROBE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_SQL_PROBE1.

select from zS05_spfli
 fields carrid,
  countryfr,
  cityfrom,
  countryto,
  cityto as cityexp,
  case when cityto EQ 'MUNICH' THEN 'THE BEST CITY'
  WHEN cityto EQ 'OSAKA' THEN 'FAR, FAR AWAY'
  WHEN cityto EQ 'JAKARTA' THEN 'HOLIDAY TIME'
  WHEN cityto EQ 'ATLANTIC CITY' THEN 'CITY OF FUN'
  ELSE cityto
  END AS cityto
  order by carrid, countryfr, cityfrom, countryto
    INTO TABLE @DATA(result1).


   cl_demo_output=>display( result1 ).



DATA:
  country TYPE zS05_scustom-country VALUE 'DE'.

cl_demo_input=>new(
  )->add_field( CHANGING field = country )->request( ).

   CONSTANTS no_street TYPE S_STREET VALUE '--Unknown--'.

   SELECT  b~customid,
          c~form,
     c~name,
     COALESCE( c~street, @no_street ) AS Adresse
     INTO TABLE @DATA(res2)

     FROM zs05_sbook as b
     LEFT OUTER JOIN  zs05_scustom as c
     ON c~id = b~customid
     AND c~country = @country.

       cl_demo_output=>display( res2 ).

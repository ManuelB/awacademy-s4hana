*&---------------------------------------------------------------------*
*& Report Z_S06_ABAPSQL_CASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S06_ABAPSQL_CASE.
 SELECT FROM spfli
   FIELDS carrid, connid,cityfrom,cityto,fltime AS Flytime,
   CASE WHEN fltime < 100 THEN 'short'
   WHEN fltime BETWEEN 100 AND 300 THEN 'medium'
   ELSE 'long'
   END AS fltime

   ORDER BY carrid, connid
   INTO TABLE @DATA(result).
cl_demo_output=>display( result ).

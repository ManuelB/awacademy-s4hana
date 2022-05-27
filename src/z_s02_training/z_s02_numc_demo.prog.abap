*&---------------------------------------------------------------------*
*& Report Z_S02_NUMC_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S02_NUMC_DEMO.


PARAMETERS:
  persnr TYPE n LENGTH 4 DEFAULT '12345',
  id TYPE c LENGTH 4 DEFAULT '1a2b3c' LOWER CASE.
*
WRITE: / persnr, id.
persnr = id.
write: / persnr.

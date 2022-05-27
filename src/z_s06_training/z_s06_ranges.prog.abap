*&---------------------------------------------------------------------*
*& Report Z_S06_RANGES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s06_ranges.
****************************************************************************************************************************************************
*PARAMETERS:
*  str_amnt TYPE p LENGTH 5 DECIMALS 2,
*  man_amnt TYPE p LENGTH 5 DECIMALS 2,
*  pud_amnt TYPE p LENGTH 5 DECIMALS 2.
*
*DATA:
*men_amnt TYPE p LENGTH 5 DECIMALS 2.
*
*CALL FUNCTION 'ZS06_CALCULATE_MENU_PRICE'
*  EXPORTING
*    str_amnt = starter
*    man_amnt = main
*    pud_amnt = pudding
*  IMPORTING
*    men_amnt = menu.
*
*FORM calculation USING starter main pudding CHANGING menu.
*
*  menu = starter + main + pudding.
*  WRITE menu.
*ENDFORM.

****************************************************************************************************************************************************

*TYPES:
*
*ty_betrag TYPE p LENGTH 7 DECIMALS 2.
*
*PARAMETERS:
*
*bwert1 TYPE ty_betrag,
*dtyp1 TYPE c LENGTH 2 DEFAULT '7',
*bwert2 TYPE ty_betrag,
*dtyp2 TYPE c LENGTH 2 DEFAULT '19'.
*
*DATA:
*
*nwert1 TYPE ty_betrag,
*dwert1 TYPE ty_betrag,
*nwert2 TYPE ty_betrag,
*dwert2 TYPE ty_betrag.
*
*
*
*PERFORM rechnen USING bwert1 dtyp1 CHANGING nwert1 dwert1.
*PERFORM rechnen USING bwert2 dtyp2 CHANGING nwert2 dwert2.
*
*"How the results will be desplayd
*WRITE: / 'ORIGINAL_PREIS!: 1', bwert1,
*/ 'MIT_RABATT:', nwert1,
*/ 'SIE_SPAREN!:', dwert1.
*
*ULINE.
*
*WRITE: / 'ORIGINAL_PREIS!: 2', bwert2,
*/ 'MIT_RABATT:', nwert2,
*/ 'SIE_SPAREN!:', dwert2.
*
*ULINE.
*
*FORM rechnen USING bwert mwst CHANGING nwert mwert.
*  CASE mwst.
*WHEN '7'.
*nwert = bwert / '1.07'.
*
*dwert1 = bwert - nwert.
*
*WHEN '19'.
*nwert = bwert / '1.19'.
*
*dwert2 = bwert - nwert.
*ENDCASE.
*ENDFORM.

****************************************************************************************************************************************************

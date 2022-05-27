FUNCTION Z12_CALCULATE_MENU_PRICE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(STARTER_AMOUNT) TYPE DEC5_2
*"     REFERENCE(MAINCOURSE_AMOUNT) TYPE DEC5_2
*"     REFERENCE(DESSERT_AMOUNT) TYPE DEC5_2
*"  EXPORTING
*"     REFERENCE(MENU_AMOUNT) TYPE DEC5_2
*"----------------------------------------------------------------------
FORM menu_price

  USING starter_amount maincourse_amount dessert_amount

  CHANGING menu_amount.

  menu_amount = '0.9' * ( starter_amount + maincourse_amount + dessert_amount ).

ENDFORM.


ENDFUNCTION.

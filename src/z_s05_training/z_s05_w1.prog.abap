*&---------------------------------------------------------------------*
*& Report Z_S05_W1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S05_W1.


SELECTION-SCREEN BEGIN OF BLOCK b1 with frame.

PARAMETERS:
       brutto1  TYPE p LENGTH 8 DECIMALS 2 DEFAULT 15,
  p_st1 TYPE c LENGTH 12  DEFAULT 'LEBENSMITTEL'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 with frame.

PARAMETERS:

       brutto2  TYPE p LENGTH 8 DECIMALS 2 DEFAULT 20,
  p_st2 TYPE c LENGTH 12 DEFAULT 'HANDELSWARE'.


SELECTION-SCREEN END OF BLOCK b2.




DATA:
  steuersum TYPE c,
  steuer TYPE p LENGTH 8 DECIMALS 2 ,
  netto TYPE p LENGTH 8 DECIMALS 2 .

IF brutto1 LE 0 OR brutto2 LE 0.
  WRITE: 'Fehler! Überprufen Sie bitte ihre Eingabe.'.
  elseif  ( p_st1 EQ 'LEBENSMITTEL' or p_st1  EQ 'HANDELSWARE' ) and ( p_st2 EQ 'LEBENSMITTEL' or p_st2  EQ 'HANDELSWARE' ).

PERFORM F_steuer USING brutto1 p_st1 CHANGING steuer netto.
PERFORM ausgabe USING brutto1 p_st1 steuer netto.


PERFORM F_steuer USING brutto2 p_st2 CHANGING steuer netto.
PERFORM ausgabe USING brutto2 p_st2 steuer netto.


ELSE.
  WRITE: 'Fehler! Überprufen Sie bitte ihre Eingabe.'.
ENDIF.


FORM F_steuer USING brutto p_st CHANGING steuer netto.
  CASE p_st.
    WHEN 'LEBENSMITTEL'.
      steuer = ( 7 / 100 ) * brutto.
        netto = brutto - steuer.
    WHEN 'HANDELSWARE'.
       steuer = ( 19 / 100 ) * brutto.
      netto = brutto - steuer.
  ENDCASE.
ENDFORM.


FORM ausgabe USING brutto p_st steuer netto.


WRITE:
/ p_st,
/ steuersum,
/ |Brutto -> { brutto } |,
/ |               -     |,
/ |Steuer -> { steuer }|,
/ |               =     |,
/ |Netto  -> { netto }|,
/.
ULINE.

ENDFORM.

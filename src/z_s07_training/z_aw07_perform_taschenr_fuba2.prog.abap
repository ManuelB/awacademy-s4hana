*&---------------------------------------------------------------------*
*& Report Z_AW07_PERFORM_TASCHENRECHNER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_perform_taschenr_fuba2.


Include Z_S07_INCLUDE_DEMO.

*PARAMETERS a1 TYPE CACSMAPFACTOR DEFAULT 5.
*PARAMETERS op1 TYPE /SAPAPO/OPERATOR DEFAULT '+'.
*PARAMETERS b1 TYPE CACSMAPFACTOR DEFAULT 17.
*
*PARAMETERS a2 TYPE CACSMAPFACTOR DEFAULT 5.
*PARAMETERS op2  TYPE /SAPAPO/OPERATOR DEFAULT '*'.
*PARAMETERS b2 TYPE CACSMAPFACTOR DEFAULT 17.
*
*
*DATA res TYPE CACSMAPFACTOR.

CALL FUNCTION 'ZS07_RECHNEN2'
  EXPORTING
   I_A                  = a1
    i_op                 = op1
    i_b                  = b1
 IMPORTING
   E_RES                = res
 EXCEPTIONS
   ZERO_DIVIDE          = 1
   WRONG_OPERATOR       = 2
   N_ARGU               = 3
   OTHERS               = 4
          .



CASE sy-subrc.
  WHEN 0.
   CALL FUNCTION 'ZS07_RECHNEN_AUSGABE'
     EXPORTING
       res           = res
    IMPORTING
      A             = a1
      OP            = op1
      B             = b1
             .

  WHEN 1.
    WRITE: / 'Null-Division'(001) COLOR COL_NEGATIVE.
  WHEN 2.
    WRITE: / TEXT-002 COLOR COL_GROUP.
  WHEN 3.
    WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
    WRITE: / 'neuer Fehler'.
ENDCASE.

CALL FUNCTION 'ZS07_RECHNEN2'
  EXPORTING
   I_A                  = a2
    i_op                 = op2
    i_b                  = b2
 IMPORTING
   E_RES                = res
 EXCEPTIONS
   ZERO_DIVIDE          = 1
   WRONG_OPERATOR       = 2
   N_ARGU               = 3
   OTHERS               = 4
          .




CASE sy-subrc.
  WHEN 0.
    CALL FUNCTION 'ZS07_RECHNEN_AUSGABE'
      EXPORTING
        res           = res
     IMPORTING
       A             = a2
       OP            = op2
       B             = b2
              .

  WHEN 1.
    WRITE: / 'Null-Division' COLOR COL_NEGATIVE.
*  WHEN 2.
*    WRITE: / 'falscher Operator' COLOR COL_GROUP.
*  WHEN 3.
*    WRITE: / 'ein anderer Fehler'.
  WHEN OTHERS.
    WRITE: / 'neuer Fehler'.
ENDCASE.


*PERFORM rechnen USING a1 op1 b1 CHANGING res.
*PERFORM ausgabe USING a1 op1 b1 res.
**
** 2. Rechnung
**PERFORM rechnen USING a2 op2 b2 CHANGING res.
*PERFORM ausgabe USING a2 op2 b2 res.

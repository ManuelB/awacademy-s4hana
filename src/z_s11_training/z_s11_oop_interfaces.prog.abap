*&---------------------------------------------------------------------*
*& Report Z_S11_OOP_INTERFACES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_oop_interfaces.

INTERFACE lif_zahlung.
  METHODS pay imPORTING im_value TYPE i. "exporting is egal when not versorgt aber importing muss versorgt werden

ENDINTERFACE.

CLASS lcl_beleg DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_zahlung. "nur im public section implementieren
ENDCLASS.

class lcl_beleg implementation.
  method lif_zahlung~pay.
    write : |Zahlung des Beleg wurde durchgeführt. Betrag : { im_value }|.
    endmethod.
  ENDCLASS.

  class lcl_sonderbeleg definition.
    public section.
    interfaces lif_zahlung.
    endclass.
    class lcl_sonderbeleg implementation.
      method lif_zahlung~pay.
        uline.
        write : |Zahlung des Sonderbeleg wurde durchgeführt. Betrag : { im_value }|.
        endmethod.
        endclass.

  START-OF-SELECTION.
  data lo_beleg type REF TO lcl_beleg.
  lo_beleg = new lcl_beleg( ).

  data lo_sonderbeleg type REF TO lcl_sonderbeleg.
  lo_sonderbeleg = new lcl_sonderbeleg( ).

  lo_beleg->lif_zahlung~pay( im_value = 100 ).
  lo_sonderbeleg->lif_zahlung~pay( im_value = 200 ).

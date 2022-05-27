*&---------------------------------------------------------------------*
*& Report z_t01_event_uebung
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s11_event_uebung.

class lcl_event_demo definition.
PUBLIC SECTION.
  EVENTS: e.

  METHODS:
    ma,
    constructor,
    on_e FOR EVENT e OF lcl_event_demo.
endclass.

CLASS lcl_event_demo IMPLEMENTATION.

  METHOD constructor.
    SET HANDLER me->on_e FOR me.
  ENDMETHOD.

  METHOD ma.
    RAISE EVENT e.
  ENDMETHOD.

  METHOD on_e.
       WRITE: / 'e wurde geworfen'.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
    DATA:
            event_demo TYPE REF TO lcl_event_demo.
    event_demo = new lcl_event_demo( ).
"    event_demo->ma(  ).
    CALL METHOD event_demo->ma.
" CALL METHOD my_oref->meth1 ...
"CALL METHOD:
"  oref1->meth1 EXPORTING im_p1 = a1 im_p2 = a2,
"  oref2->meth3,
"  oref3->set_name EXPORTING im_Name = 'Maier' ).
"oref1->meth1( im_p1 = a1 im_p2 = a2).
"oref2->meth3( ).
"oref3->set_name( 'Maier' ).

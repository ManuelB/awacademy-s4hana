*&---------------------------------------------------------------------*
*& Report Z_S05_XPROBE9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S11_ASS2_UMLTOCODE.

interface  fahrzeug.
  endinterface.

  interface auto.
    methods:
    besitzer importing im_besitzer type string,
    max_geschwindigkeit returning value(re_max) type i.

    endinterface.

    class teslamodel3 definition.
      public section.
      INTERFACES:
      auto.
      methods:
      vollgas.

      data:
            batterie type i,
            nummernschild type string,
            geschwindigkeit type i,
            besitzer type string.

      endclass.

      class teslamodel3 implementation.

       method auto~besitzer.
       me->besitzer = im_besitzer.
       endmethod.

       method auto~max_geschwindigkeit.
        re_max = geschwindigkeit.
        endmethod.

        method vollgas.
          WRITE: 'Vollgas'.
          endmethod.
          endclass.

*          START-OF-SELECTION.
*
*          DATA lo_auto type ref to teslamodel3.
*
*          lo_auto = new teslamodel3( ).
*
*          lo_auto->auto~besitzer( im_besitzer = 'Max Mustermann' ).
*          lo_auto->auto~max_geschwindigkeit( ).
*          lo_auto->vollgas( ).

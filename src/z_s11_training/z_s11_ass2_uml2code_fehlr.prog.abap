
REPORT Z_S11_ASS2_UML2CODE_FEHLR.
interface lif.
  data : farbe type string.
  methods: bezahlen.
endinterface.

class pkw DEFINITION.
public section.
  methods:
  fahren,
  tanken,
  get_farbe returning value(re_farbe) type string.


  data: km type i,
        farbe type string.
  PROTECTED SECTION.
  private section.

  endclass.

  class pkw IMPLEMENTATION.

    method fahren.
      endmethod.
      method get_farbe.
        endmethod.
        method tanken.
          endmethod.

    endclass.

    class taxi definition inheriting from pkw.
      public section.
      interfaces: lif.
      methods:
      fahren redefinition,
      tanken redefinition.
*      get_km returning value(re_km) type i.
      endclass.

      class taxi implementation.
        method fahren.
          endmethod.
*          method bezahlen.
*            endmethod.
            method tanken.
              ENDMETHOD.
              method lif~bezahlen.
                endmethod.
        endclass.

        START-OF-SELECTION.
DATA :
my_pkw TYPE REF TO pkw,
my_taxi TYPE REF TO taxi,
my_lif TYPE REF TO lif.
CREATE OBJECT: my_pkw, my_taxi." my_lif.
my_lif = my_taxi.
WRITE:/ my_lif->farbe.
write:/ my_taxi->km.
write:/ my_pkw->farbe.

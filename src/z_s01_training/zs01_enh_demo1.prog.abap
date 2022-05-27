REPORT ZS01_ENH_DEMO1.
write: / 'Zeile 1 Original'.
ENHANCEMENT-SECTION zdemo2 SPOTS ZRK1.
  WRITE:/ ' Original.'.
  END-ENHANCEMENT-SECTION.



write: / 'Zeile 2 Original'.
write: / 'Zeile 3 Original'.

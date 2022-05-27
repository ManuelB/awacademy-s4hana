REPORT z_s05_dyn_einlesen.
*DATA: summe TYPE i.
*SELECT-OPTIONS:
* zahl FOR summe.
**
*LOOP AT zahl.
*  summe = summe + zahl-low.
*ENDLOOP.
*WRITE: / 'Fertig:', summe.

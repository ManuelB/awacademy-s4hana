*&---------------------------------------------------------------------*
*& Report Z_S01_GUI_ELEMENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_S01_GUI_ELEMENTS.

* Alles verstanden.


*Hier merkenswert eine Variable reicht für alle Eingaben aus.
DATA lv_zahl TYPE i.

*Befehl für Textfeld. Wert in Textfeld wird in Variable geschrieben.
PARAMETERS p_param LIKE lv_zahl.

*Select-OPTIONS = textfeld für Eingabe mehrerer Werte. No INTERVALS verhindert, dass das zweite Eingabefeld auf dem Selektionsbild auftaucht.
Select-OPTIONS so_sel FOR lv_Zahl No INTERVALS.

*Damit wird eine Checkbox gemacht, die mit Default auf X gestellt ist, leerzeichen ist boolean unwahr
PARAMETERS p_check AS CHECKBOX DEFAULT 'X'.

*Multiple choice buttons. Group ordnet sie in eine Gruppe, sodass nur eine ausgewählt werden kann.
PARAMETERS p_rad1 RADIOBUTTON GROUP rb_1.

PARAMETERS p_rad2 RADIOBUTTON GROUP rb_1.

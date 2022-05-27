INTERFACE z_s10_i_auto
  PUBLIC .
  METHODS besitzer importing im_besitzer type string.
  METHODS max_geschwindigkeit RETURNING VALUE(max_g) type i.

ENDINTERFACE.

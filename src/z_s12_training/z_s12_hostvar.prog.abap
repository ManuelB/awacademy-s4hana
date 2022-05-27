*&---------------------------------------------------------------------*
*& Report Z_S12_HOSTVAR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_s12_hostvar.
INCLUDE Z_t04_i_Flugdaten.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME.
*  PARAMETERS p_carr TYPE s_carr_id. "zawt03_airpfrom. "p_carr -> Textelemente -> Selektionselemente -> Text = Startflughafen
*SELECTION-SCREEN END OF BLOCK a1.
*
*START-OF-SELECTION.
*
*  SELECT SINGLE * INTO @DATA(flights)"Zielstruktur bestimmt durch Eingabe nach SELECT SINGLE "@Fluchtsymbol/Hostvariable
*    FROM sflight
*    WHERE carrid = @p_carr.
*
*  BREAK-POINT.

"******************************************************************************************************************************************
"Aufgabe
*SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME.
*  PARAMETERS: p_carr   TYPE s_carr_id, "Parameter nach denen sich suche
*              p_cityfr TYPE s_from_cit.
*SELECTION-SCREEN END OF BLOCK a2.
*
*START-OF-SELECTION.
*
*  SELECT SINGLE carrid, connid, cityfrom INTO @DATA(flights) "Zielstruktur "Sucht einen Satz SELECT SINGLE
*       FROM spfli "suchst aus
*    WHERE
*    carrid = @p_carr
*    AND cityfrom = @p_cityfr. "Was ich ausgegeben haben will
*
*  WRITE: / flights.
*
*  BREAK-POINT.
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  SELECTION-SCREEN BEGIN OF BLOCK a3 WITH FRAME.
*    PARAMETERS: p_carr   TYPE s_carr_id default 'LH',
*                p_connid TYPE s_conn_id default '0400'.
*  SELECTION-SCREEN END OF BLOCK a3.
*
*  SELECT SINGLE carrid, connid, price INTO @DATA(flights)
*       FROM sflight
*    WHERE
*    carrid = @p_carr
*    AND connid = @p_connid.
*
*    update sflight set price = '100.00' where carrid = 'LH' and connid = '0400'.
*    commit work.


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Aufgabe
      SELECTION-SCREEN BEGIN OF BLOCK a4 WITH FRAME.
    PARAMETERS: p_carr   TYPE s_carr_id default 'LH',
                p_connid TYPE s_conn_id default '2407'.
  SELECTION-SCREEN END OF BLOCK a4.

  SELECT SINGLE carrid, connid INTO @DATA(flights)
       FROM spfli
    WHERE
    carrid = @p_carr
    AND connid = @p_connid.

    update spfli set cityfrom = 'MÜNCHEN' where carrid = 'LH' and connid = '2407'.
    commit work.

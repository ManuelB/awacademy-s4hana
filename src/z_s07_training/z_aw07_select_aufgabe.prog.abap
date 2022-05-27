*&---------------------------------------------------------------------*
*& Report Z_AW07_SELECT_AUFGABE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aw07_select_aufgabe.

*DATA : BEGIN OF wa,
*         carrid   TYPE sflight-carrid,
*         connid   TYPE sflight-connid,
*         seatsocc TYPE sflight-seatsocc,
*       END OF wa,
*       tline LIKE TABLE OF wa
*               WITH NON-UNIQUE DEFAULT KEY.
*
*SELECT carrid, connid, SUM( seatsocc ) AS belegt
*  FROM sflight
*  GROUP BY carrid, connid
*  ORDER BY carrid, connid
*  INTO @DATA(line).
*
*  INSERT line INTO TABLE tline.
*
*ENDSELECT.
*
*cl_demo_output=>display( tline ).

*DATA: cityto TYPE spfli-cityto,
*      cityfrom TYPE spfli-airpfrom.



*PARAMETERS p_cityf TYPE s_from_cit DEFAULT 'NEW YORK'.

*SELECT count( DISTINCT carrid )
*  FROM spfli
*  WHERE cityto = 'WALLDORF'
*  INTO @DATA(Ziel_WALLDORF).
*  cl_demo_output=>display( Ziel_WALLDORF ).






DATA: cityto TYPE spfli-cityto VALUE 'NY',
      cityfrom TYPE spfli-cityfrom VALUE 'FRA'.


cl_demo_input=>new(
)->add_field( CHANGING field = cityto
)->add_field( CHANGING field = cityfrom )->request( ).

  SELECT DISTINCT cityto
    FROM spfli
    WHERE carrid = 'LH' and
    cityfrom = 'FRANKFURT'
    INTO TABLE @DATA(destinations).
cl_demo_output=>display( destinations ).

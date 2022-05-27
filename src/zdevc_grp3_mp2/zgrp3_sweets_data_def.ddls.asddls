@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Definition für Dealing Sweets'
define root view entity ZGRP3_SWEETS_DATA_DEF
  as select from zgrp3_sweets
    inner join   zgrp3_bestand  on(
       zgrp3_sweets.artikelnummer = zgrp3_bestand.artikelnummer
     )
    inner join   zgrp3_filstamm on(
      zgrp3_bestand.filialnummer = zgrp3_filstamm.filialnummer
    )
{
  key zgrp3_filstamm.filialnummer           as Filialnummer,
  key zgrp3_sweets.artikelnummer            as Artikelnummer,
 @Semantics.quantity.unitOfMeasure : 'Mengeneinheit'
      zgrp3_bestand.min_bestand             as MinBestand ,
      @Semantics.quantity.unitOfMeasure : 'Mengeneinheit'
      zgrp3_bestand.max_bestand             as MaxBestand,
      @Semantics.quantity.unitOfMeasure : 'Mengeneinheit'
      zgrp3_bestand.aktueller_lagerbestand  as AktuellerLagerbestand,
      zgrp3_bestand.mengen_einheit          as Mengeneinheit,
      zgrp3_filstamm.filialbezeichnung      as Filialbezeichnung,
      zgrp3_filstamm.ort                    as Ort,
      zgrp3_filstamm.strasse                as Strasse,
      zgrp3_filstamm.plz                    as Plz,
      zgrp3_filstamm.telefon                as Telefon,
      zgrp3_filstamm.name_anlage_aenderung  as NameAnlageAenderung,
      zgrp3_filstamm.datum_anlage_aenderung as DatumAnlageAenderung,
      zgrp3_sweets.artikelgruppe            as Artikelgruppe,
      zgrp3_sweets.artikelname              as Artikelname,
      @Semantics.amount.currencyCode: 'Waehrung'
      zgrp3_sweets.einkauf_netto            as EinkaufNetto,
      @Semantics.amount.currencyCode: 'Waehrung'
      zgrp3_sweets.mind_brutto              as MindBrutto,
      zgrp3_sweets.waehrung                 as Waehrung,
      @Semantics.amount.currencyCode: 'Waehrung'
      zgrp3_sweets.vk_brutto                as VkBrutto,
      zgrp3_sweets.activeflag               as Activeflag,
      zgrp3_sweets.datum                    as Datum,
      zgrp3_sweets.uname                    as Uname
}

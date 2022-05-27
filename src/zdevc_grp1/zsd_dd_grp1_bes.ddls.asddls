@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bestandstabelle'



define root view entity ZSD_DD_GRP1_BES
  as select from zsd_grp1_sw
    inner join   zsd_grp1_bes on(
      zsd_grp1_sw.artnr = zsd_grp1_bes.artnr
    )
    inner join   zsd_grp1_fs  on(
       zsd_grp1_bes.filnr = zsd_grp1_fs.filnr
     )
{

      @UI.facet: [ { id:              'zsdgrp1mp2',
      purpose:         #STANDARD,
      type:            #IDENTIFICATION_REFERENCE,
      label:           'zsdgrp1mp2',
      position:        110 } ]
      @UI.hidden: true
 key zsd_grp1_sw.artnr      as Artnr,
  
  
  
      @UI: {
           selectionField: [ { position: 10 } ] ,
           lineItem:       [ { position: 10} ],
           identification: [ { position: 10 } ] }
    key zsd_grp1_fs.filnr      as Filnr,
  
  
      @UI: {

      lineItem:       [ { position: 30} ],
      identification: [ { position: 30 } ] }
      zsd_grp1_sw.artname    as Artname,


      @UI: {
      selectionField: [ { position: 20 } ] ,
      lineItem:       [ { position: 20} ],
      identification: [ { position: 20 } ] }
      zsd_grp1_sw.artgr      as Artgr,


      zsd_grp1_sw.salesunit  as Salesunit,
     
     
      zsd_grp1_sw.curr       as waehrung,
      @Semantics.amount.currencyCode: 'waehrung'
      @UI: {

      lineItem:       [ { position: 50} ],
      identification: [ { position: 50 } ] }
      zsd_grp1_sw.vkpreis    as Vkpreis,
      
      zsd_grp1_sw.activeflag as Activeflag,
      
      zsd_grp1_sw.datum      as Datum,
     
      @Semantics.quantity.unitOfMeasure:'Salesunit'
      zsd_grp1_bes.mdbes     as Mdbes,
      @Semantics.quantity.unitOfMeasure:'Salesunit'
      zsd_grp1_bes.mxbes     as Mxbes,
      @UI: {

      lineItem:       [ { position: 60} ],
      identification: [ { position: 60 } ] }
      @Semantics.quantity.unitOfMeasure:'Salesunit'
      zsd_grp1_bes.akbes     as Akbes,
     
      @UI: {
      lineItem:       [ { position: 40} ],
      identification: [ { position: 40 } ] }
      zsd_grp1_fs.filname    as Filname,

      zsd_grp1_fs.ort        as Ort,

      zsd_grp1_fs.strasse    as Strasse,

      zsd_grp1_fs.plz        as Plz,
      zsd_grp1_fs.tel        as Tel,
      
      @UI: {
      lineItem:       [ { position: 70} ],
      identification: [ { position: 70 } ] }
      zsd_grp1_fs.userid     as Userid
     
}

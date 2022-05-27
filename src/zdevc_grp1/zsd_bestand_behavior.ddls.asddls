@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bestandstabelle'



define root view entity ZSD_BESTAND_BEHAVIOR
  as select from zsd_grp1_sw
    
{

      @UI.facet: [ { id:              'zsdgrp1mp2',
      purpose:         #STANDARD,
      type:            #IDENTIFICATION_REFERENCE,
      label:           'zsdgrp1mp2',
      position:        110 } ]
      @UI.hidden: true
 key zsd_grp1_sw.artnr      as Artnr,
  
  
  
     
  
  
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
      
      zsd_grp1_sw.datum      as Datum
     
     
      
      
     
}

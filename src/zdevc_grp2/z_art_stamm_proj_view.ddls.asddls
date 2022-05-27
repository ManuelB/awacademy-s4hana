@EndUserText.label: 'Projektion'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity Z_ART_STAMM_PROJ_VIEW as projection on z_art_stamm {
 @UI.facet: [ { id:              'Artikelnummer',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Artikelnummer',
                     position:        10 } ]
    @UI: {
          lineItem:       [ { position: 30, importance: #MEDIUM } ],
          identification: [ { position: 30 } ] }
    
    key Artikelnummer as Artikelnummer, 
    
     
     
    Artikelgruppe,
    @UI: {
      lineItem:       [ { position: 60, importance: #HIGH },
                        { type: #FOR_ACTION, dataAction: 'auslisten', label: 'Auslisten' } ],
      identification: [ { position: 60, label: 'Artikelname' } ]  }
    Artikelname,
    EkNetto,
    MvpBrutto,
    VpBrutto,
    Activeflag,
    DatAnlage,
    UserNameAnlage,
    Waehrung
}

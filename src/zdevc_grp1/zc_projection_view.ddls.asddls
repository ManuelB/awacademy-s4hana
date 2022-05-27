@EndUserText.label: 'Bestandstabelle'
@AccessControl.authorizationCheck: #NOT_REQUIRED
//@UI: {
//headerInfo: { typeName: 'Travel', typeNamePlural: 'Travels', title: {
//type: #STANDARD, value: 'TravelID' } } }
@Search.searchable: true
define root view entity ZC_projection_View as projection on ZSD_BESTAND_BEHAVIOR {
    key Artnr,
    Artname,
    Artgr,
    Salesunit,
    waehrung,
    Vkpreis,
    Activeflag,
    Datum
}

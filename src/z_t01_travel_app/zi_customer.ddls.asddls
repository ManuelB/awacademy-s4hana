@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer View - CDS Data Model'
@Search.searchable: true
define view entity ZI_CUSTOMER
  as select from scustom as Customer

  association [0..1] to I_Country as _Country on $projection.CountryCode = _Country.Country

{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['CustomerName']
  key Customer.id         as CustomerID,
 
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      Customer.name       as CustomerName,

      Customer.street     as Street,
      Customer.postcode   as PostalCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Customer.city       as City,

      @Consumption.valueHelpDefinition: [{entity: { name: 'I_Country', element: 'Country' } }]
      Customer.country    as CountryCode,

      Customer.telephone  as PhoneNumber,

      Customer.email      as EMailAddress,

      /* Associations */
      _Country

}

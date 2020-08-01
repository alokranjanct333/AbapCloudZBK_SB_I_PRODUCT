@AbapCatalog.sqlViewName: 'ZARICURR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Currency'
define view ZAR_I_CURRENCY
  as select from I_Currency
{
  //I_Currency
  key Currency,
  Decimals,
  CurrencyISOCode,
  AlternativeCurrencyKey,
  IsPrimaryCurrencyForISOCrcy,
  /* Associations */
  //I_Currency
  _Text
}

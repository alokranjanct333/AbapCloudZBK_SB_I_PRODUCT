@AbapCatalog.sqlViewName: 'ZARIUSCONT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view - User contancts'
define view ZAR_I_USER_CONTACTS
  as select from zar_d_us_contact
{

  key userid,
  key appuser,
      first_name,
      last_name,
      email,
      phone,
      mobile
}

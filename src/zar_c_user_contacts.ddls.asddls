@AbapCatalog.sqlViewName: 'ZARCUSCONT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'User contacts'
define view ZAR_C_USER_CONTACTS
  as select from ZAR_I_USER_CONTACTS
{
  key userid,
  key appuser,
      concat_with_space(first_name, last_name, 1 )            as FullName,
      email,
      phone,
      mobile,
      concat(concat('/webapp/images/users/', appuser),'.jpg') as UserImg
}

@AbapCatalog.sqlViewName: 'ZARCMRKTORD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view - Market Orders'
@Metadata.allowExtensions: true
@Search.searchable: true
define view ZAR_C_MRKT_ORDER
  as select from zar_d_mrkt_order as _Order
  association to parent ZAR_C_PROD_MRKT     as _Market      on $projection.mrkt_uuid = _Market.mrkt_uuid 
  association [0..*] to ZAR_C_USER_CONTACTS as _CreateUser  on _Order.created_by     = _CreateUser.userid
  association [0..*] to ZAR_C_USER_CONTACTS as _ChangeUser  on _Order.changed_by     = _ChangeUser.userid  
{
  key _Order.order_uuid,
      _Order.mrkt_uuid,
      @Search: {
         defaultSearchElement: true,
         ranking: #HIGH,
         fuzzinessThreshold: 0.8
        }      
      _Order.orderid,
      _Order.quantity,
      _Order.calendar_year,
      _Order.delivery_date,
       @Semantics.amount.currencyCode: 'amountcurr'
      _Order.netamount,
      @Semantics.amount.currencyCode: 'amountcurr'
      _Order.grossamount,
      @Semantics.currencyCode: true
      _Order.amountcurr,
      
      _CreateUser.appuser as createuser,
      @Semantics.user.createdBy: true
      _Order.created_by,
      @Semantics.systemDateTime.createdAt: true
      cast( _Order.creation_time as timestamp ) as creation_time,
      _ChangeUser.appuser as changeuser,
      @Semantics.user.lastChangedBy: true
      _Order.changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      cast( _Order.change_time as timestamp )   as change_time,
      
      'https://i7.pngguru.com/preview/423/632/57/computer-icons-purchase-order-order-fulfillment-purchasing-order-icon.jpg' as OrderImg,
      _Market,
      _CreateUser,
      _ChangeUser
}

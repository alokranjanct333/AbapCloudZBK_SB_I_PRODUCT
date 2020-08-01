@AbapCatalog.sqlViewName: 'ZARIPHS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bacis view - Phases'
define view ZAR_I_PHASES as select from zar_d_phases {
    key phaseid,
        phase
}

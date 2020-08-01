CLASS lhc_Market DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS checkDuplicates FOR VALIDATION Market~checkDuplicates
      IMPORTING keys FOR Market.

    METHODS validateEndDate FOR VALIDATION Market~validateEndDate
      IMPORTING keys FOR Market.

    METHODS validateMarketName FOR VALIDATION Market~validateMarketName
      IMPORTING keys FOR Market.

    METHODS validateStartDate FOR VALIDATION Market~validateStartDate
      IMPORTING keys FOR Market.

    METHODS confirmMarket FOR MODIFY
      IMPORTING keys FOR ACTION Market~confirmMarket RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Market RESULT result.

ENDCLASS.

CLASS lhc_Market IMPLEMENTATION.

  METHOD checkDuplicates.

    READ ENTITY zar_c_prod_mrkt
         FIELDS ( prod_uuid mrkt_uuid mrktid )
         WITH VALUE #( FOR key IN keys ( %key = key-%key ) )
    RESULT DATA(lt_current_market).

    LOOP AT lt_current_market INTO DATA(ls_current_market).

      SELECT * FROM zar_d_prod_mrkt
                    WHERE prod_uuid = @ls_current_market-prod_uuid
                    INTO TABLE @DATA(lt_prod_mrkt).

      READ TABLE lt_prod_mrkt WITH KEY mrktid = ls_current_market-mrktid TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        APPEND VALUE #(  mrkt_uuid = ls_current_market-mrkt_uuid ) TO failed.

        APPEND VALUE #(  mrkt_uuid = ls_current_market-mrkt_uuid
                         %msg      = new_message( id       = 'ZAR_PROD_MESS'
                                                  number   = '007'
                                                  v1       = ls_current_market-mrktid
                                                  severity = if_abap_behv_message=>severity-error )

                         %element-mrktid = if_abap_behv=>mk-on ) TO reported.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateEndDate.

    READ ENTITY zar_c_prod_mrkt
         FIELDS ( startdate enddate )
         WITH VALUE #( FOR key IN keys ( %key = key-%key ) )
    RESULT DATA(lt_market_result).

    LOOP AT lt_market_result INTO DATA(ls_market).

      IF ls_market-enddate < ls_market-startdate.
        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid ) TO failed.

        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid
                         %msg      = new_message( id       = 'ZAR_PROD_MESS'
                                                  number   = '006'
                                                  v1       = ls_market-enddate
                                                  severity = if_abap_behv_message=>severity-error )

                         %element-enddate = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateMarketName.

    READ ENTITY zar_c_prod_mrkt
         FIELDS ( mrktid )
         WITH VALUE #( FOR key IN keys ( %key = key-%key ) )
    RESULT DATA(lt_market_result).

    LOOP AT lt_market_result INTO DATA(ls_market).

      SELECT * FROM zar_d_market WHERE mrktname = @ls_market-mrktid
                                 INTO TABLE @DATA(lt_market_names).
      IF sy-subrc <> 0.
        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid ) TO failed.

        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid
                         %msg      = new_message( id       = 'ZAR_PROD_MESS'
                                                  number   = '003'
                                                  v1       = ls_market-mrktid
                                                  severity = if_abap_behv_message=>severity-error )

                         %element-mrktid = if_abap_behv=>mk-on ) TO reported.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateStartDate.

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    READ ENTITY zar_c_prod_mrkt
         FIELDS ( startdate enddate )
         WITH VALUE #( FOR key IN keys ( %key = key-%key ) )
    RESULT DATA(lt_market_result).

    LOOP AT lt_market_result INTO DATA(ls_market).

      IF ls_market-enddate IS NOT INITIAL AND ls_market-enddate < lv_today.
        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid ) TO failed.

        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid
                         %msg      = new_message( id       = 'ZAR_PROD_MESS'
                                                  number   = '004'
                                                  v1       = ls_market-enddate
                                                  severity = if_abap_behv_message=>severity-error )

                         %element-enddate = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

* If Start Date is not in the future => raise the error
      IF ls_market-startdate IS NOT INITIAL AND ls_market-startdate < lv_today.
        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid ) TO failed.

        APPEND VALUE #(  mrkt_uuid = ls_market-mrkt_uuid
                         %msg      = new_message( id       = 'ZAR_PROD_MESS'
                                                  number   = '005'
                                                  v1       = ls_market-startdate
                                                  severity = if_abap_behv_message=>severity-error )

                         %element-startdate = if_abap_behv=>mk-on ) TO reported.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD confirmMarket.

    DATA lv_status TYPE abap_bool.

    READ ENTITY zar_c_prod_mrkt
        FROM VALUE #(
        FOR key IN keys (  %key = key-%key
                           %control = VALUE #( mrktid  = if_abap_behv=>mk-on
                                               status  = if_abap_behv=>mk-on   ) )  )
        RESULT DATA(lt_markets).

    LOOP AT lt_markets INTO DATA(ls_market).

      CASE ls_market-status.
        WHEN abap_true.
          lv_status = abap_false.
        WHEN OTHERS.
          lv_status = abap_true.
      ENDCASE.

      MODIFY ENTITY zar_c_prod_mrkt
          UPDATE SET FIELDS WITH VALUE #( ( %key            = ls_market-%key
                                            status          = lv_status
                                            %control-status = if_abap_behv=>mk-on ) )
          REPORTED DATA(ls_reported).
      APPEND LINES OF ls_reported-market TO reported-market.

      " Read changed data for action result
      READ ENTITY zar_c_prod_mrkt
           FROM VALUE #( ( %key            = ls_market-%key
                           %control-status = if_abap_behv=>mk-on ) )
           RESULT DATA(lt_market_result).

      result = VALUE #( FOR ls_current_market IN lt_market_result (  %key     = ls_current_market-%key
                                                                     %param   = ls_current_market ) ).

    ENDLOOP.
  ENDMETHOD.

  METHOD get_features.

    "%control-<fieldname> specifies which fields are read from the entities

    READ ENTITY zar_c_prod_mrkt FROM VALUE #( FOR keyval IN keys
                                                      (  %key            = keyval-%key
                                                         %control-mrktid = if_abap_behv=>mk-on
                                                         %control-status = if_abap_behv=>mk-on
                                                        ) )
                                RESULT DATA(lt_market_result).

    LOOP AT lt_market_result INTO DATA(ls_market).
      result = VALUE #( (  %key                            = ls_market-%key
                           %features-%action-confirmMarket = COND #(  WHEN ls_market-status = abap_true
                                                                      THEN if_abap_behv=>fc-o-disabled
                                                                      ELSE if_abap_behv=>fc-o-enabled )  )  ).
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_Product DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setFirstPhase FOR DETERMINATION Product~setFirstPhase
      IMPORTING keys FOR Product.

    METHODS validateProductGr FOR VALIDATION Product~validateProductGr
      IMPORTING keys FOR Product.

    METHODS validateProductId FOR VALIDATION Product~validateProductId
      IMPORTING keys FOR Product.

    METHODS moveToNextPhase FOR MODIFY
      IMPORTING keys FOR ACTION Product~moveToNextPhase RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Product RESULT result.

ENDCLASS.

CLASS lhc_Product IMPLEMENTATION.

  METHOD setFirstPhase.
  ENDMETHOD.

  METHOD validateProductGr.
  ENDMETHOD.

  METHOD validateProductId.
  ENDMETHOD.

  METHOD moveToNextPhase.
  ENDMETHOD.

  METHOD get_features.
  ENDMETHOD.

ENDCLASS.


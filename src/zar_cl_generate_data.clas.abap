CLASS zar_cl_generate_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zar_cl_generate_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_prod_grs  TYPE TABLE OF zar_d_prod_group,
          lt_phases    TYPE TABLE OF zar_d_phases,
          lt_markets   TYPE TABLE OF zar_d_market,
          lt_user_cont TYPE TABLE OF zar_d_us_contact,
          lt_uom       TYPE TABLE OF zar_d_uom.
*** PRODUCT GROUPS
*   fill internal table (itab)
    lt_prod_grs = VALUE #(
        ( pgid  = '1' pgname = 'Microwave'      imageurl = 'https://png.pngtree.com/png-clipart/20190517/original/pngtree-vector-microwave-oven-icon-png-image_4015182.jpg' )
        ( pgid  = '2' pgname = 'Coffee Machine' imageurl = 'https://icon-library.com/images/coffee-maker-icon/coffee-maker-icon-13.jpg' )
        ( pgid  = '3' pgname = 'Waffle Iron'    imageurl = 'https://previews.123rf.com/images/anatolir/anatolir1810/anatolir181004863/110698658-waffle-maker-icon-outline-style.jpg' )
        ( pgid  = '4' pgname = 'Blender'        imageurl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRSLnFTOSs5ZV0d8pwhPzs4KANsvq1oZ7hyrg&usqp=CAU' )
        ( pgid  = '5' pgname = 'Cooker'         imageurl = 'https://st4.depositphotos.com/18657574/22404/v/1600/depositphotos_224044856-stock-illustration-stove-concept-vector-linear-icon.jpg' )
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zar_d_prod_group.
*   insert the new table entries
    INSERT zar_d_prod_group FROM TABLE @lt_prod_grs.

*   check the result
    SELECT * FROM zar_d_prod_group INTO TABLE @lt_prod_grs.
    out->write( sy-dbcnt ).
    out->write( 'product groups data inserted successfully!').

*** PHASES
*   fill internal table (itab)
    lt_phases = VALUE #(
        ( phaseid  = '1' phase = 'PLAN' )
        ( phaseid  = '2' phase = 'DEV' )
        ( phaseid  = '3' phase = 'PROD' )
        ( phaseid  = '4' phase = 'OUT' )
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zar_d_phases.
*   insert the new table entries
    INSERT zar_d_phases FROM TABLE @lt_phases.

*   check the result
    SELECT * FROM zar_d_phases INTO TABLE @lt_phases.
    out->write( sy-dbcnt ).
    out->write( 'phases data inserted successfully!').

*** MARKETS
*   fill internal table (itab)
    lt_markets = VALUE #(
        ( mrktid  = '1' mrktname = 'Russia'  imageurl = 'https://cdn.webshopapp.com/shops/94414/files/54940426/russia-flag-image-free-download.jpg' )
        ( mrktid  = '2' mrktname = 'Belarus' imageurl = 'https://cdn.countryflags.com/thumbs/belarus/flag-400.png' )
        ( mrktid  = '3' mrktname = 'UK'      imageurl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Flag_of_the_United_Kingdom.svg/640px-Flag_of_the_United_Kingdom.svg.png' )
        ( mrktid  = '4' mrktname = 'France'  imageurl = 'https://cdn.webshopapp.com/shops/94414/files/54002660/france-flag-image-free-download.jpg' )
        ( mrktid  = '5' mrktname = 'Germany' imageurl = 'https://cdn.webshopapp.com/shops/94414/files/54006402/germany-flag-image-free-download.jpg' )
        ( mrktid  = '6' mrktname = 'Italy'   imageurl = 'https://cdn.countryflags.com/thumbs/italy/flag-400.png' )
        ( mrktid  = '7' mrktname = 'USA'     imageurl = 'https://cdn.webshopapp.com/shops/94414/files/54958906/the-united-states-flag-image-free-download.jpg' )
        ( mrktid  = '8' mrktname = 'Japan'   imageurl = 'https://image.freepik.com/free-vector/illustration-japan-flag_53876-27128.jpg' )
        ( mrktid  = '9' mrktname = 'Poland'  imageurl = 'https://cdn.webshopapp.com/shops/94414/files/54940016/poland-flag-image-free-download.jpg' )
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zar_d_market.
*   insert the new table entries
    INSERT zar_d_market FROM TABLE @lt_markets.

*   check the result
    SELECT * FROM zar_d_market INTO TABLE @lt_markets.
    out->write( sy-dbcnt ).
    out->write( 'markets data inserted successfully!').

*** User Contacts
*   fill internal table (itab)
    lt_user_cont = VALUE #(
        ( userid = 'CB0000000024' appuser  = 'KBLAGUSHKO' first_name = 'Karina' last_name = 'Blagushko'
          email = 'karinablagushko@gmail.com' phone = '4563212' mobile = '3245678')
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zar_d_us_contact.
*   insert the new table entries
    INSERT zar_d_us_contact FROM TABLE @lt_user_cont.

*   check the result
    SELECT * FROM zar_d_us_contact INTO TABLE @lt_user_cont.
    out->write( sy-dbcnt ).
    out->write( 'user contacts data inserted successfully!').

*** UOM
*   fill internal table (itab)
    lt_uom = VALUE #(
        ( msehi = 'CM'  dimid = 'LENGTH' isocode = 'CMT')
        ( msehi = 'DM'  dimid = 'LENGTH' isocode = 'DMT')
        ( msehi = 'FT'  dimid = 'LENGTH' isocode = 'FOT')
        ( msehi = 'IN'  dimid = 'LENGTH' isocode = 'INH')
        ( msehi = 'KM'  dimid = 'LENGTH' isocode = 'KMT')
        ( msehi = 'M'   dimid = 'LENGTH' isocode = 'MTR')
        ( msehi = 'MI'  dimid = 'LENGTH' isocode = 'SMI')
        ( msehi = 'MIM' dimid = 'LENGTH' isocode = '4H')
        ( msehi = 'MM'  dimid = 'LENGTH' isocode = 'MMT')
        ( msehi = 'NAM' dimid = 'LENGTH' isocode = 'C45')
        ( msehi = 'YD'  dimid = 'LENGTH' isocode = 'YRD')
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zar_d_uom.
*   insert the new table entries
    INSERT zar_d_uom FROM TABLE @lt_uom.

*   check the result
    SELECT * FROM zar_d_uom INTO TABLE @lt_uom.
    out->write( sy-dbcnt ).
    out->write( 'uom data inserted successfully!').
  ENDMETHOD.

ENDCLASS.

function checkNumForMonth( month ) {
  if ( month.length === 2 ) {
    return month
  } else {
    return "0" + month;
  };
};

$( document ).ready( function() {
  $( '#all-cards' ).DataTable({
    responsive: true,
    searching: false,
    paging: false
  });

  $( "#new-card-trig" ).on( 'click', function( e ) {
    e.preventDefault();
    $( '#sectional-form-plug-card' ).toggle();
  });

  $( 'form#new-card-submission' ).on( 'submit', function( e ) {
    e.preventDefault();
    var elements = e.target.elements;
    var method = e.target.method;
    var url = e.target.action;
    var data = ""

    $.each( elements, function( idx, element ) {
      if ( element.name === "card-number" ) {
        data += ( "payment_method[cnum]=" + element.value.replace(/ /g,'') + "&" );
      } else if ( element.className === "expiry-month" ) {
        data += ( "payment_method[cem]=" + checkNumForMonth( element.value ) + "&" );
      } else if ( element.className === "expiry-year" ) {
        data += ( "payment_method[cey]=" + element.value + "&" );
      } else if ( element.className === "cvc" ) {
        data += ( "payment_method[ccvv]=" + element.value + "&" );
      } else if ( element.className === "expiry" ) {
        return true;
      } else {
        data += ( element.name + "=" + element.value + "&" );
      };
    });

    $.ajax({
      method: method,
      url: url,
      data: data
    }).done( function( response ) {
      $( "#all-cards tbody" ).append( response );
      document.getElementById( 'new-card-submission' ).reset();
      $( '#sectional-form-plug-card' ).toggle();
      $.toast({
          heading: 'System Message',
          text: 'Payment Method was successfully added!',
          position: 'top-center',
          loaderBg: '#fff',
          icon: 'success',
          hideAfter: 3500,
          stack: 6
      });
    });
  });
});

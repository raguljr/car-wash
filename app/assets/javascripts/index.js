$(document).ready(function() {

  $(window).scroll(function() {
    if($(this).scrollTop() > 40) { 
        $('.navbar').addClass('solid');
    } else {
        $('.navbar').removeClass('solid');
    }
  });

  $('navbar-toggler').click(function(){
  	('navbar-collapsed').addClass('solid');
  });

  $('.select-category').change(function(){
    if(window.location.href.match(/(what=)[^\&]+/) == undefined) {
      var url = window.location.href.replace("what=","what="+ $(this).val())
    }
    else{
      var url = window.location.href.replace(/(what=)[^\&]+/, '$1' + $(this).val());
    }
    console.log(url);
    window.location.href = url;
  });

});

document.addEventListener("turbolinks:load", function() {
  $( "#city" ).autocomplete({
    source: function( request, response ) {
      $.ajax( {
        url: "where_autocomplete",
        data: {
          term: request.term
        },
        success: function( data ) {
          response( data );
        }
      });
    }});

  $( "#what" ).autocomplete({
    source: function( request, response ) {
      $.ajax( {
        url: "what_autocomplete",
        data: {
          term: request.term
        },
        success: function( data ) {
          response( data );
        }
      });
    }});


});
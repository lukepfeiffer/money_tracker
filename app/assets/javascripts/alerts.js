$(document).ready(function(){
  setTimeout(function(){

    var query = window.location.search.substring(1)

    if(query.length) {
      if(window.history != undefined && window.history.pushState != undefined) {
        window.history.pushState({}, document.title, window.location.pathname);
      }
    }
    $('.alert').fadeOut('slow');
  })
});

$(document).ready(function(){
  $('#category').on('click', '#add-category', function(event) {
    event.preventDefault();
    $('#add-category').hide();
    $('#cancel').show();
    $('.hidden-form').show();
  });

  $('#category').on('click', '#cancel', function(event) {
    event.preventDefault();
    $('#cancel').hide();
    $('#add-category').show();
    $('.hidden-form').hide();
  });

});

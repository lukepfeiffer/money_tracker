$(document).ready(function(){
  $('#category').on('click', '#add-category', function(event) {
    event.preventDefault();
    debugger
    $('.hidden-form').toggle();
  });
});

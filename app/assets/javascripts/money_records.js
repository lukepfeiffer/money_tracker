$(document).ready(function(){
  // Show category filter

  $('#history').on('click', '.show-category-filter', function(event) {
    $('.category-search-form').toggle(100);
  })

  // Show edit fields

  $('.table-row').on('click', '.edit, .cancel', function(event){
    event.preventDefault();
    $(this).closest('tr').find('.field, .text, .cancel, .edit').toggle();
  })

});

$(document).ready(function(){
  // Show category filter

  $('#history').on('click', '.show-category-filter', function(event) {
    $('.category-search-form').toggle(100);
  });

  // Toggle edit fields

  $('.table-row').on('click', '.edit, .cancel', function(event){
    event.preventDefault();
    $(this).closest('tr').find('.field, .text, .cancel, .edit').toggle();
  });

  // Edit text

  $('.table-row').on('submit', '.edit_form', function(event){
    event.preventDefault
    var form = $(this)
    debugger
    $.ajax({type: "patch",
      url: form.attr("action"),
      data: form.serialize(),
      success: function(response){
        debugger
        form.closest('tr').replaceWith(response)
      }
    })
  });

});

$(document).ready(function(){

  // Show create category form

  $('#categories').on('click', '#add-category', function(event) {
    event.preventDefault();
    $('#add-category').hide();
    $('#cancel').show();
    $('.hidden-form').show();
  });


  // Hide create category form

  $('#categories').on('click', '#cancel', function(event) {
    event.preventDefault();
    $('#cancel').hide();
    $('#add-category').show();
    $('.hidden-form').hide();
  });

  // Ajax create category

  $('#categories #new').submit(function(event){
    event.preventDefault();
    var form = $(this)
    $.ajax({type: 'post',
      url: form.attr('action'),
      data: form.serialize(),
      success: function(response){
        $('.hidden-form').hide();
        $('#add-category').show();
        $('.category-container').append(response)
      }
    })
  });

  // Ajax archive category

  $('#categories').on('click', '.archive', function(){
    var button = $(this)
    var categoryId = $(this).closest('.small-cards').data('id')
    $.ajax({type: 'delete',
      url: button.data('url'),
      success: function(){
        button.closest('.category').remove();
      }
    })
  });

  // Show add money form

});

$(document).ready(function(){
  $('#categories').on('click', '#add-category', function(event) {
    event.preventDefault();
    $('#add-category').hide();
    $('#cancel').show();
    $('.hidden-form').show();
  });

  $('#categories').on('click', '#cancel', function(event) {
    event.preventDefault();
    $('#cancel').hide();
    $('#add-category').show();
    $('.hidden-form').hide();
  });

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

  $('#categories').on('click', '.archive', function(){
    var button = $(this)
    var categoryId = $(this).closest('.category').data('id')
    $.ajax({type: 'delete',
      url: button.data('url'),
      success: function(){
        button.closest('.category').remove();
      }
    })
  });

});

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
    $.ajax({type: 'delete',
      url: button.data('url'),
      success: function(){
        button.closest('.category').remove();
      }
    })
  });

  // Show add money form

  $('#categories').on('click', '.edit-funds', function(event){
    var button = $(this)

    event.preventDefault();

    button.hide();
    button.parent().children('.money-record-form').show();
    button.parent().children('cancel-funds').show();
  })

  // Hide add money form

  $('#categories').on('click', '.cancel-funds', function(event){
    var button = $(this)
    event.preventDefault();
    button.closest('.money-record-form').hide();
    button.parent().parent().parent().children('.edit-funds').show()
  })

  // Adjust money on category

  $('#categories').on('submit', '.money-record-form', function(event){
    var form = $(this)
    var categoryId = $(this).closest('.category').data('id')

    event.preventDefault()

    $.ajax({type: 'post',
      url: form.attr('action') + '?category_id='+ categoryId,
      data: form.serialize(),
      success: function(response){
        form.closest('.category').replaceWith(response)
      }
    })
  })

});

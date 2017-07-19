$(document).ready(function(){
  // Ajax archive category

  $('#categories').on('click', '.archive', function(){
    var button = $(this)
    $.ajax({type: 'delete',
      url: button.data('url'),
      success: function(){
        button.closest('.category').fadeOut(300, function(){ $(this).remove();});
        $('#categories').prepend("<div class= 'flash-primary alert'> <span> Archived </span></div>")
      },
      error: function(){
        $('#categories').prepend("<div class= 'flash-danger alert'> <span> Archive Failed </span></div>")
      }
    })
  });

  // Ajax unarchive category

  $('#categories').on('click', '.unarchive', function(){
    var button = $(this)
    $.ajax({type: 'delete',
      url: button.data('url'),
      success: function(){
        button.closest('.category').fadeOut(300, function(){ $(this).remove();});
        $('#categories').prepend("<div class= 'flash-primary alert'> <span> Unarchived </span></div>")
      },
      error: function(){
        $('#categories').prepend("<div class= 'flash-danger alert'> <span> Unarchive Failed</span></div>")
      }
    })
  });

  // Show add money form

  $('#categories').on('click', '.edit-funds', function(event){
    var button = $(this)
    var form = button.parent().children('.money-record-form')
    var cardCopy = button.parent().parent();
    event.preventDefault();

    form.show();
    button.hide();
    cardCopy.addClass('extra-padding');
    button.parent().children('.cancel-funds').show();
    button.parent().children('.archive').hide();
  })

  // Hide add money form

  $('#categories').on('click', '.cancel-funds', function(event){
    var button = $(this)
    var cardCopy = button.parent().parent().parent().parent();
    event.preventDefault();
    cardCopy.removeClass('extra-padding');
    button.closest('.money-record-form').hide();
    button.parent().parent().parent().children('.edit-funds').show()
    button.parent().parent().parent().children('.archive').show()
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
        $('#categories').prepend("<div class= 'flash-primary alert'> <span> Adjusted Funds </span></div>")
      },
      error: function(){
        $('#categories').prepend("<div class= 'flash-danger alert'> <span> Unable to Adjust </span></div>")
      }
    })
  })

  setTimeout(function(){
    $('.alert').fadeOut('slow');
  }, 4000)

});

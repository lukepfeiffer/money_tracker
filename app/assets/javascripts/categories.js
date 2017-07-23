$(document).ready(function(){
  // Filter categories
  $(".list").on("click", ".top-container", function() {
    var categoryOption = $(this);
    var categoryName = $(this).data('name');
    var categoryId = $(this).data('id');
    var newH1 = "<h1 class='records_for'> Records for " + categoryName + "</h1>";

    $.ajax({
      type: "get",
      url: "/categories/" + categoryId,
      success: function(response){
        $(".records_for").replaceWith(newH1);
        $(".table-container").replaceWith(response);
      }
    });
  });

  // Archive Categories
  $(".item").on("click", ".danger", function() {
    var button = $(this);

    $.ajax({
      type: "delete",
      url: button.data("url"),
      success: function(response){
        button.fadeOut(300, function(){
          button.closest(".item").remove();
        });
      }
    });
  });

  // Restore Categories
  $(".item").on("click", ".restore", function() {
    var button = $(this);

    $.ajax({
      type: "delete",
      url: button.data("url"),
      success: function(response){
        button.fadeOut(300, function(){
          button.closest(".item").remove();
        });
      }
    });
  });
});

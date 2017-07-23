$(document).ready(function(){
  $(".list").on("click", ".item", function() {
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
});

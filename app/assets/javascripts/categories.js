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
  $(".item").on("click", ".archive", function() {
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
  $(".item").on("click", ".restore", function(event) {
    event.preventDefault();
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

  // Show/Hide money record form
  $(".item").on("click", ".transaction, .cancel", function(event){
    event.preventDefault();
    $(this).parent().children(".hidden_form").toggle()
  });

  $(".item").on("click", ".cancel", function(event){
    event.preventDefault();
    $(this).closest(".hidden_form").toggle()
  });

  $(".item").on("submit", ".new_record", function(event){
    event.preventDefault();
    var form = $(this);
    var amount = $("#money_record_amount").val();
    var balanceHTML = $(this).parent().children(".balance")
    var balanceText = balanceHTML.text();
    var balance = parseFloat(balanceText.substring(1, balanceText.length).replace(/,/g, "")) + parseFloat(amount);
    var newBalance = '$' + balance.toFixed(2).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");


    $.ajax({
      type: "post",
      url: form.attr("action"),
      data: form.serialize(),
      success: function(response){
        $(".table-container").replaceWith(response);
        balanceHTML.text(newBalance);
        $(".hidden_form").hide();
      }
    });
  });
});

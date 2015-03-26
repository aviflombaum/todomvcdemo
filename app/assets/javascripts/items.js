// event listener for the new item form on submit

// ajax submit a POST request to make a new item (submit the form via ajax)

function Item(){

};

Item.update = function(e){
  var $checkbox = $(this)
  var $form = $(this).parents("form:first")
  var href = $form.attr("action")

  // if (this.checked){
  //   var status = 1;
  // } else if (!this.checked){
  //   var status = 0;
  // }

  // var listId;
  // var itemId;

  // Hard coded URL suck

  $.ajax(href, {
    "method": "PATCH",
    "data": $form.serialize(),
    "success": function(response){
      $checkbox.parents("li:first").toggleClass("completed");

      // // if the status is 1 then addClass completed to parent li
      // if ($checkbox.is(":checked")){
      //   $checkbox.parents("li:first").addClass("completed");
      // } else {
      //   $checkbox.parents("li:first").removeClass("completed");
      // }
    }
  })
}

Item.create = function(e){
  e.preventDefault();

  var $form = $(this);
  var href = $form.attr("action");

  $.ajax(href, {
    "data": $form.serialize(),
    "method": "POST",
    "success": function(response){
      // Before this line fires, an entire request/response rails
      // cycle happened.
      $(".new-todo", $form).val("");

      $("ul#todo-list").prepend(response);
    }
  }) // Building a HTTP Request
};

$(function(){
  $("form#new_item").on("submit", Item.create)
  // Event Delegation
  $("ul.list").on("change","input:checkbox", Item.update)

  // $("ul.lists").on("click", "button.destroy", deleteList);  
});


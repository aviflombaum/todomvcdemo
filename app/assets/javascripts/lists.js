function createList(e){
  e.preventDefault();
  var $form = $(this);

  var url = $form.attr("action");

  $.post(url, $form.serialize() , function(listLI){
    $(".new-todo", $form).val("");

    $("ul").prepend(listLI);
  });
};

function removeList($li){
  
}

function deleteList(e){
  e.preventDefault();
  var $li = $(this).parents("li");

  // it needs to actually remove it from the database    
  // DELETE /lists/:id 
  var href = $("form", $li).attr("action");

  $.ajax(href, {
    "method": "DELETE",
    "success": function(){
      // remove the list that was just clicked on from the DOM
      // the page has many lis, I want ot find the one that was just clicked on
     // debugger
      $li.slideUp(function(){
        $(this).remove();
      });
    }
  })
}

// function eventDelegation(e){
//   if ($(e.target).is("button.destroy")){
//     deleteList(e);
//   }
// }

$(function(){// When page is loaded fire me. Alias of $(document).ready()
  $("form#new_list").on("submit", createList);  

  // $("button.destroy").on("click", deleteList);
  // $("ul").on("click", eventDelegation);
  
  $("ul.lists").on("click", "button.destroy", deleteList);
});

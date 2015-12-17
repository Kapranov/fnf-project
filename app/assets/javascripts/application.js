//= require jquery
//= require jquery_ujs

 
//= require jquery-2.1.1
//= require bootstrap.min
//= require plugins/metisMenu/jquery.metisMenu
//= require plugins/slimscroll/jquery.slimscroll.min
//= require jquery.jcrop
//= require steps

// $(document).ready(function(){
//   $("#follow_button").submit(function(){
//     $.put($(this).attr("action"), $(this).serialize(), null, "script");
//     return false;
//   })
// })

$(function() {
  $("#employees th a, #employees .pagination a").on("click", "a", function() {
    $.getScript(this.href);
    return false;
  });
  $("#employees_search input").keyup(function() {
    $.get($("#employees_search").attr("action"), $("#employees_search").serialize(), null, "script");
    return false;
  });
});
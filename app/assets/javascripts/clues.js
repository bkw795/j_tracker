$(document).ready( function(){
  $(".respond_to_clue").click( function(){
    $(".response_choices").hide();
    $(".response_menu").show();
  });

  $(".pass_on_clue").click( function(){
    $(".response_choices" ).hide();
    $(".pass_menu").show();
  });
});

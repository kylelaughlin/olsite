// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on("turbolinks:load", function(){
      $(".button-collapse").sideNav();
      $('.materialboxed').materialbox();

      $("#schedule").on("click", function(){
        if($("#expanded").hasClass("hide")){
          $("#expanded").removeClass("hide");
        }else{
          $("#expanded").addClass("hide");
        };
      });


})

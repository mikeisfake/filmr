// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery-ui

$('input[type=radio]').click(function() {
  $("#movie-list").submit();
});

$(".flash").addClass("animated slideInLeft").delay(3000).queue(function () {
  $(this).addClass("slideOutLeft").dequeue();
});

$( "#btn, #blocker" ).click(function() {
  $( "#menu, #blocker, .container-all" ).toggleClass( "open", 250, "easeOutCirc" );
  $( "#btn" ).toggleClass( "active");
});

$(".close-button").click(function() {
  $(".search-container").remove();
});

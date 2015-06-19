# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#$("form input[type='text']").keyup(function(event) {
#  if(event.keyCode == 27) {alert(1);}
#})

$('document').ready () ->
  $("form input[type='text']").keyup (event) ->
    if event.keyCode == 27
      alert 1
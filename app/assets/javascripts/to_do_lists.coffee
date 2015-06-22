# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$('document').ready () ->
  $("form input[type='text']").keyup (event) ->
    that = this;
    if event.keyCode == 27
      $(that).parents('form').find('button').click();
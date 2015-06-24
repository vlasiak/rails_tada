# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class TodoItem
  initialize: () ->
    @bindAddEvents()
    @bindCancelEvents()
    @bindKeyPressEvents()

  bindAddEvents: () ->
    $.each $('div.list a'), (_, value) =>
      @expandOnClick value

  bindCancelEvents: () ->
    $.each $('div.list form button'), (_, value) =>
      @collapseOnClick value

  bindKeyPressEvents: () ->
    $("form input[type='text']").keypress (event) ->
      self = this
      if event.keyCode == 27
        $(self).parents('form').find('button').click()

  expandOnClick: (element) ->
    $(element).click (event) =>
      event.preventDefault()
      $container = $(element).parent()

      $(element).toggle()
      $container.find('form').toggle()
      @makeFocusOn $container.find("input[type='text']")

  collapseOnClick: (element) ->
    $(element).click (event) ->
      $(this).closest('div').find('a').toggle()
      $(this).closest('form').toggle()

  makeFocusOn: (element) ->
    element.val('').focus()


  # it is possible that you would need this method
  add: () ->
    #...

  create: () ->
    # a set of method to handle adding of a just saved item


$ ->
  todoItem = new TodoItem
  todoItem.initialize()
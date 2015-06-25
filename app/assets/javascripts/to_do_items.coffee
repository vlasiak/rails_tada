# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoItem
  initialize: () ->
    bindAddEvents()
    bindCancelEvents()
    bindEscKeyEvents()

  onCreate: (options) ->
    removeCallout(options.listId)
    appendNewOne(options.listId, options.html)
    focusOn(options.listId)
    highlightNewOne(options.id) if options.id


  appendNewOne = (listId, html) ->
    $('#list-' + listId + ' ul').append(html)

  focusOn = (listId) ->
    makeFocusOn $('#form-' + listId + " input[type='text']")

  highlightNewOne = (id) ->
    $('#item-' + id).css({'background-color':'#ffffe0'}).
      animate({'background-color':'#fff'}, 2000)

  removeCallout = (listId ) ->
    $('#list-' + listId + ' div.bs-callout').remove()

  bindAddEvents = () ->
    $.each $('div.list a'), (_, value) =>
      expandOnClick value

  bindCancelEvents = () ->
    $.each $('div.list form button'), (_, value) =>
      collapseOnClick value

  bindEscKeyEvents = () ->
    $("form input[type='text']").keypress (event) ->
      if event.keyCode == 27
        $(this).parents('form').find('button').click()

  expandOnClick = (element) ->
    $(element).click (event) =>
      event.preventDefault()
      $container = $(element).parent()

      $(element).toggle()
      $container.find('form').toggle()
      makeFocusOn $container.find("input[type='text']")

  collapseOnClick = (element) ->
    $(element).click (event) ->
      $(this).closest('div').find('a').toggle()
      $(this).closest('form').toggle()

  makeFocusOn = (element) ->
    element.val('').focus()

$ ->
  todoItem = new TodoItem
  todoItem.initialize()
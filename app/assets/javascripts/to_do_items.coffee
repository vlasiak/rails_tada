# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoItem
  initialize: () ->
    bindAddEvents()

  onCreate: (options) ->
    removeCallout options.listId
    appendNewOne options.listId, options.html
    focusOn options.listId
    highlightNewOne options.id if options.id

  appendNewOne = (listId, html) ->
    detectList(listId).find('ul').append html

  focusOn = (listId) ->
    detectFormInput(listId).val('').focus()

  highlightNewOne = (id) ->
    detectItem(id).css({'background-color':'#ffffe0'}).
      animate({'background-color':'#fff'}, 2000)

  detectList = (id) ->
    $("#list-#{id}")

  detectItem = (id) ->
    $("#item-#{id}")

  detectAddLink = (id) ->
    $("#add-item-link-#{id}")

  detectForm = (id) ->
    $("#form-#{id}")

  detectFormInput = (id) ->
    $("#item-input-#{id}")

  detectCancelFormButton = (id) ->
    $("#cancel-item-button-#{id}")

  removeCallout = (listId) ->
    detectList(listId).find('div.bs-callout').remove()

  bindAddEvents = () ->
    $.each $('div.list a'), (_, value) =>
      id = value['id'].split('-').pop()
      expandOnClick id

  bindCancelEvent = (id) ->
    collapseOnClick id

  bindEscKeyEvent = (id) ->
    detectFormInput(id).keypress (event) ->
      detectCancelFormButton(id).click() if event.keyCode == 27

  initializeForm = (id, html) ->
    detectList(id).append html
    focusOn id
    bindCancelEvent id
    bindEscKeyEvent id

  drawForm = (url, id) ->
    $.get(url).complete (response) =>
      initializeForm id, response.responseText

  expandOnClick = (id) ->
    $addItemLink = detectAddLink(id)
    $addItemLink.click () ->
      $addItemLink.toggle()
      $form = detectForm id
      if $form.length
        $form.toggle()
        focusOn id
      else
        drawForm $addItemLink.attr('href'), id
      return false

  collapseOnClick = (id) ->
    detectCancelFormButton(id).click (event) =>
      removeCallout id
      detectAddLink(id).toggle()
      detectForm(id).toggle()

$ ->
  todoItem = new TodoItem
  todoItem.initialize()
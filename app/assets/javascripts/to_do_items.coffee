# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoItem
  initialize: () ->
    bindAddEvents()
    bindCheckEvents()

  onCreate: (options) ->
    removeCallout options.listId
    appendNewOne options.listId, options.html
    focusOn options.listId
    highlightNewOne options.id if options.id

  appendNewOne = (listId, html) ->
    detectList(listId).find('ul.incomplete').append html

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

  extractId = (str) ->
    str.split('-').pop()

  removeCallout = (listId) ->
    detectList(listId).find('div.bs-callout').remove()

  saveOnClick = (item) ->
    $(item).click () ->
      updateItem extractId item['id']

  markAsDone = (id, listId) ->
    completeList = detectList(listId).find('ul.complete')
    detectItem(id).appendTo completeList

  unmark = (id, listId) ->
    incompleteList = detectList(listId).find('ul.incomplete')
    detectItem(id).appendTo incompleteList

  updateItem = (id) ->
    $.ajax
      url: "to_do_items/#{id}"
      method: 'PUT'
      error: (response) ->
        console.log 'fail'
      success: (response) ->
        if response.done == true
          markAsDone id, response.list_id
        else
          unmark id, response.list_id

  bindAddEvents = () ->
    $.each $('div.list a'), (_, value) =>
      id = extractId value['id']
      expandOnClick id

  bindCheckEvents = () ->
    $.each $("div.list input[type='checkbox']"), (_, value) =>
      saveOnClick value

  bindCancelEvent = (id) ->
    collapseOnClick id

  bindEscKeyEvent = (id) ->
    detectFormInput(id).keypress (event) ->
      detectCancelFormButton(id).click() if event.keyCode == 27

  initializeForm = (id, html) ->
    detectList(id).find('ul.incomplete').after html
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
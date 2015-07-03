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
    checkOnClick detectCheckbox(options.id)[0]

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

  detectCheckbox = (id) ->
    $("#item-cb-#{id}")

  detectAddLink = (id) ->
    $("#add-item-link-#{id}")

  detectForm = (id) ->
    $("#form-#{id}")

  detectFormInput = (id) ->
    $("#item-input-#{id}")

  detectCancelFormButton = (id) ->
    $("#cancel-item-button-#{id}")

  extractId = (itemId) ->
    itemId.split('-').pop()

  removeCallout = (listId) ->
    detectList(listId).find('div.bs-callout').remove()

  checkOnClick = (item) ->
    $(item).click () ->
      doCheckRequest $(item)

  toggle = (options) ->
    list = detectList options.list_id
    destinationList =
      if options.done
        list.find('ul.complete')
      else
        list.find('ul.incomplete')
    detectItem(options.id).appendTo destinationList

  revertChecking = (id) ->
    currentCheckbox = $("##{id}")
    currentCheckbox.prop 'checked', !currentCheckbox.prop 'checked'

  showCheckAlert = (listId) ->
    alertBox = detectList(listId).find('div.alert')
    if alertBox.css('display') == 'none'
      alertBox.fadeIn 'slow'
      alertBox.delay 3000
      alertBox.fadeOut 'slow'

  doCheckRequest = (item) ->
    $.ajax
      url: item.attr('url')
      method: 'PUT'
      error: () ->
        revertChecking item.attr('id')
        showCheckAlert item.attr('value')
      success: (response) ->
        toggle response

  bindAddEvents = () ->
    $.each $('div.list a'), (_, value) =>
      id = extractId value['id']
      expandOnClick id

  bindCheckEvents = () ->
    $.each $("div.list input[type='checkbox']"), (_, value) =>
      checkOnClick value

  bindCancelEvent = (id) ->
    collapseOnClick id

  bindEscKeyEvent = (id) ->
    detectFormInput(id).keypress (event) ->
      detectCancelFormButton(id).click() if event.keyCode == 27

  initializeForm = (id, html) ->
    detectList(id).find('div.alert').after html
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
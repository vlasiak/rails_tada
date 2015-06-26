# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @TodoItem
  initialize: () ->
    bindAddEvents()

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

  bindCancelEvent = (form) ->
    collapseOnClick form.find('button')

  bindEscKeyEvent = (form) ->
    form.find("input[type='text']").keypress (event) ->
      form.find('button').click() if event.keyCode == 27

  initializeForm = (form) ->
    makeFocusOn form.find("input[type='text']")
    bindCancelEvent(form)
    bindEscKeyEvent(form)

  drawForm = (url, container) ->
    $.get(url).complete (response) =>
      container.append(response.responseText)
      initializeForm container.find('form')

  expandOnClick = (element) ->
    $(element).click (event) ->
      event.preventDefault()
      $container = $(element).parent()
      $form = $container.find('form')
      $(element).toggle()
      if $form.length
        $form.toggle()
        makeFocusOn $form.find("input[type='text']")
      else
        drawForm($(this).attr('href'), $container)

  collapseOnClick = (element) ->
    $(element).click (event) ->
      $(this).closest('div').find('a').toggle()
      $(this).closest('form').toggle()

  makeFocusOn = (element) ->
    element.val('').focus()

$ ->
  todoItem = new TodoItem
  todoItem.initialize()